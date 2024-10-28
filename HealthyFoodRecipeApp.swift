//
//  HealthFoodRecipeApp.swift
//  HealthFoodRecipe
//
//  Created by Jamila Ruzimetova on 3/19/24.
//

import SwiftUI
import SwiftData

@main
struct HealthyFoodRecipeApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @State private var container: ModelContainer?
    
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
            }
            .onChange(of: scenePhase) { _, newPhase in
                if newPhase == .active {
                    validateReceiptAndRefreshToken()
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
            guard let modelContext = container?.mainContext else {
                print("Error: ModelContext is not available")
                return
            }
            
            await DataImporter(modelContext: modelContext).importData(resetLastChangeTime: false)
        }
    }
}
