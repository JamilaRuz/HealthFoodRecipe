import Foundation
import UserNotifications
import UIKit

class NotificationManager: ObservableObject {
    static let shared = NotificationManager()
    private let userDefaults = UserDefaults.standard
    private let tokenKey = "pending_device_token"
    private let lastAttemptKey = "last_token_registration_attempt"
    private let retryIntervalMinutes: TimeInterval = 60 // 60 for production
    private let retryTimerToleranceSeconds: TimeInterval = 300 // 300 for production
    private var retryTimer: Timer?
    
    @Published var hasPermission = false
    @Published var deviceToken: String?
    
    private var environment: String {
        #if DEBUG
        return "sandbox"
        #else
        return "production"  // Both TestFlight and App Store use production APNS
        #endif
    }
    
    init() {
        // Check for pending registrations on init
        checkPendingRegistration()
        
        // Setup retry timer
        setupRetryTimer()
        
        // Observe app lifecycle for retries
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appDidBecomeActive),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
    }
    
    deinit {
        retryTimer?.invalidate()
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func appDidBecomeActive() {
        checkPendingRegistration()
    }
    
    private func setupRetryTimer() {
        // Create a timer for retry attempts
        retryTimer = Timer.scheduledTimer(
            withTimeInterval: retryIntervalMinutes * 60,
            repeats: true
        ) { [weak self] _ in
            self?.checkPendingRegistration()
        }
        retryTimer?.tolerance = retryTimerToleranceSeconds
    }
    
    private func checkPendingRegistration() {
        guard let pendingToken = userDefaults.string(forKey: tokenKey) else { return }
        
        let lastAttempt = userDefaults.double(forKey: lastAttemptKey)
        let currentTime = Date().timeIntervalSince1970
        
        // Only retry if enough time has passed since last attempt
        if currentTime - lastAttempt >= retryIntervalMinutes * 60 {
            Task {
                await sendTokenToServer(pendingToken)
            }
        }
    }
    
    private func storePendingToken(_ token: String) {
        userDefaults.set(token, forKey: tokenKey)
        userDefaults.set(Date().timeIntervalSince1970, forKey: lastAttemptKey)
    }
    
    private func clearPendingToken() {
        userDefaults.removeObject(forKey: tokenKey)
        userDefaults.removeObject(forKey: lastAttemptKey)
    }
    
    func requestPermission() async {
        do {
            let granted = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
            await MainActor.run {
                self.hasPermission = granted
                if granted {
                    // Register for remote notifications if permission granted
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            }
        } catch {
            print("Error requesting notification permission: \(error)")
        }
    }
    
    func refreshNotificationSettings() async {
        let settings = await UNUserNotificationCenter.current().notificationSettings()
        await MainActor.run {
            self.hasPermission = settings.authorizationStatus == .authorized
        }
    }
    
    func handleDeviceToken(_ deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
        
        // Store token for later use
        DispatchQueue.main.async {
            self.deviceToken = token
        }
        
        // Send token to server
        Task {
            await sendTokenToServer(token)
        }
    }
    
    private func sendTokenToServer(_ token: String) async {
        print("Sending token to server: \(token)")
        
        guard let url = URL(string: ApiConf.registerPushDeviceTokenUrl) else {
            print("Invalid URL for token registration")
            return
        }
        
        let body: [String: String] = [
            "token": token,
            "environment": environment
        ]
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response type")
                storePendingToken(token)
                return
            }
            
            if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
                print("Successfully registered device token with server")
                clearPendingToken() // Clear any pending token on success
            } else {
                print("Failed to register device token. Status code: \(httpResponse.statusCode)")
                if let errorJson = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let errorMessage = errorJson["error"] as? String {
                    print("Error message: \(errorMessage)")
                }
                storePendingToken(token) // Store token for retry
            }
        } catch {
            print("Error registering device token: \(error)")
            storePendingToken(token) // Store token for retry on network errors
        }
    }
} 
