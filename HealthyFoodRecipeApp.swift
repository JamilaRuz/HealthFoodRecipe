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
    
    let container = try! ModelContainer(for: Recipe.self)
    let postLoader = PostLoader()
    
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
                    let name = post.name
                    let descriptor = FetchDescriptor<Recipe>(predicate: #Predicate { $0.name == name })
                    let count = (try? context.fetchCount(descriptor)) ?? 0
                    
                    if count == 0 {
                        let category = Category(name: post.category.name, image: "breakfast")
                        
                        let ingredients = post.ingredients.map { postIngredient in
                            Ingredient(name: postIngredient.ingredient.name, unit: postIngredient.unit, quantity: postIngredient.quantity)
                        }
                        
                        let recipe = Recipe(id: post.id, name: post.name, images: post.pictures, ingredients: ingredients, instructions: post.instructions, category: category, isFavorite: false, menuItems: [])
                        
                        
                        context.insert(recipe)
                    } else {
                        // Recipe already exists, handle accordingly or skip
                        print("Recipe already exists: \(post.name)")
                    }
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
