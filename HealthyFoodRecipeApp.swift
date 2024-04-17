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
    
    let container = try! ModelContainer(for: Recipe.self)
    let postLoader = PostLoader()
    
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            MenuItem.self, Recipe.self
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
//
//        do {
//            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
//
//            return container
//
////            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//
//
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
//
    @MainActor
    private func importData() async {
        //        get access to the context
        let context = container.mainContext
        //        save posts to the local context
        do {
            let posts = try await postLoader.loadPosts()
            if !posts.isEmpty {
        // insert data into local db
                posts.forEach { post in
                    let category = Category(name: post.category.name, image: "breakfast")
                    
                    let ingredients = post.ingredients.map { postIngredient in
                        Ingredient(name: postIngredient.ingredient.name, unit: postIngredient.unit, quantity: postIngredient.quantity)
                    }
                    
                    let recipe = Recipe(name: post.name, images: post.pictures, ingredients: ingredients, instructions: post.instructions, category: category, isFavorite: false, menuItems: [])
                    
                    context.insert(recipe)
                }
            }
        } catch {
            print("Could not load posts: \(error)")
        }
        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    await importData()
                }
        }
        .modelContainer(container)
    }
}
