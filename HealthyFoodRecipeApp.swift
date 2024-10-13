//
//  HealthFoodRecipeApp.swift
//  HealthFoodRecipe
//
//  Created by Jamila Ruzimetova on 3/19/24.
//

import SwiftUI
import SwiftData
import CoreData

@main
struct HealthyFoodRecipeApp: App {
    @Environment(\.scenePhase) private var scenePhase
    let container = try! ModelContainer(for: Recipe.self)

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .active {
                validateReceiptAndRefreshToken()
            }
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
                    print("Receipt validated and token refreshed successfully")
                    refreshDataFromServer()
                } else {
                    print("Failed to validate receipt or refresh token")
                }
            }
        }
    }
    
    private func refreshDataFromServer() {
        Task { @MainActor in
            await DataImporter(modelContext: container.mainContext).importData(resetLastChangeTime: false)
        }
    }
}
