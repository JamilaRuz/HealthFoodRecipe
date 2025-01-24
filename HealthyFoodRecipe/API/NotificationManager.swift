//
//  NotificationManager.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 12/19/24.
//

import Foundation
import UserNotifications
import SwiftUI

@MainActor
class NotificationManager: NSObject, ObservableObject {
    static let shared = NotificationManager()
    
    @Published var isPermissionGranted = false
    
    override init() {
        super.init()
        Task {
            await setupNotificationDelegate()
        }
    }
    
    private func setupNotificationDelegate() async {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
    }
    
    func requestPermission() async {
        do {
            let settings = await UNUserNotificationCenter.current().notificationSettings()
            if settings.authorizationStatus != .authorized {
                let granted = try await UNUserNotificationCenter.current().requestAuthorization(
                    options: [.alert, .badge, .sound]
                )
                await MainActor.run {
                    self.isPermissionGranted = granted
                }
            }
            await MainActor.run {
                UIApplication.shared.registerForRemoteNotifications()
            }
        } catch {
            print("Error requesting notification permission: \(error)")
        }
    }
    
    func refreshNotificationSettings() async {
        let settings = await UNUserNotificationCenter.current().notificationSettings()
        await MainActor.run {
            self.isPermissionGranted = settings.authorizationStatus == .authorized
        }
    }
    
    func handleDeviceToken(_ deviceToken: Data) {
        let tokenString = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("Device Token: \(tokenString)")
        // Send this token to your server
        // TODO: Implement your server communication here
    }
}

@MainActor
extension NotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification) async
    -> UNNotificationPresentationOptions {
        return [.banner, .sound, .badge]
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse) async {
        // Handle notification tap here
        let userInfo = response.notification.request.content.userInfo
        // Process the notification data
    }
}
