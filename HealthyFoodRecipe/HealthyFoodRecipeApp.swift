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
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            MenuItem.self, Recipe.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
