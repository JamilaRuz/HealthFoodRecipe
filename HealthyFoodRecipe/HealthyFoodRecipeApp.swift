//
//  HealthFoodRecipeApp.swift
//  HealthFoodRecipe
//
//  Created by Jamila Ruzimetova on 3/19/24.
//

import SwiftUI
import SwiftData
import UIKit
import UserNotifications

@main
struct HealthyFoodRecipeApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @State private var container: ModelContainer?
    @StateObject private var notificationManager = NotificationManager()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            Group {
                if let container = container {
                    SplashScreen()
                        .modelContainer(container)
                } else {
                    ProgressView("Loading...")
                }
            }
            .task {
                await setupModelContainer()
                await notificationManager.requestPermission()
            }
            .onChange(of: scenePhase) { _, newPhase in
                if newPhase == .active {
                    validateReceiptAndRefreshToken()
                    Task { @MainActor in
                        await notificationManager.refreshNotificationSettings()

                        UNUserNotificationCenter.current().setBadgeCount(0) { error in
                            if let error = error {
                                print("Error clearing badge count: \(error)")
                            }
                        }
                        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
                    }
                }
            }
           .onReceive(NotificationCenter.default.publisher(for: Notification.Name("UIApplicationDidFailToRegisterForRemoteNotificationsError"))) { notification in
               if let error = notification.userInfo?["error"] as? Error {
                   print("Failed to register for notifications: \(error)")
               }
           }
        }
    }
    
    private func setupModelContainer() async {
        do {
            let container = try await createModelContainer()
            self.container = container
        } catch {
            print("Failed to create model container: \(error)")
            // Handle the error appropriately, e.g., show an error message to the user
        }
    }
    
    private func createModelContainer() async throws -> ModelContainer {
        let schema = Schema([Recipe.self, MenuItem.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            print("Error creating ModelContainer: \(error)")
            print("Attempting to recreate the database...")
            
            // Attempt to delete the existing store
            if let storeURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first?.appendingPathComponent("default.store") {
                try? FileManager.default.removeItem(at: storeURL)
            }
            
            // Try creating the container again
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        }
    }
    
    private func validateReceiptAndRefreshToken() {
        ReceiptManager.shared.fetchReceiptData { receiptData in
            guard let receiptData = receiptData else {
                print("Failed to fetch receipt data")
                return
            }
            
            ReceiptManager.shared.sendReceiptToServer(receiptData: receiptData) { success in
                if success {
                    print("Receipt validated and auth token refreshed successfully")
                    refreshDataFromServer()
                } else {
                    print("Failed to validate receipt or refresh auth token")
                }
            }
        }
    }
    
    private func refreshDataFromServer() {
        Task { @MainActor in
            guard let modelContext = container?.mainContext else {
                print("Error: ModelContext is not available")
                return
            }
            
            await DataImporter(modelContext: modelContext).importData(resetLastChangeTime: false)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        NotificationManager.shared.handleDeviceToken(deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications: \(error)")
    }
    
    // Handle notifications when app is in foreground
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound, .badge])
    }
    
    // Handle notification taps
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let userInfo = response.notification.request.content.userInfo
        print("Notification tapped: \(userInfo)")
        completionHandler()
    }
}
