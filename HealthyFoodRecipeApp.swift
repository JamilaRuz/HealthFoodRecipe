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
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .task {
          await importData()
        }
    }
    .modelContainer(container)
  }
  
  @MainActor
  private func importData() async {
    do {
      let posts = try await postLoader.loadPosts()
      if !posts.isEmpty {
        posts.forEach { post in
          let id = post.id
          let descriptor = FetchDescriptor<Recipe>(predicate: #Predicate { $0.id == id })
          let foundRecipes = (try? container.mainContext.fetch(descriptor)) ?? [Recipe]()
          
          if foundRecipes.count == 0 {
            insertRecipe(post)
          } else {
            updateRecipe(post: post, existingRecipe: foundRecipes[0])
          }
          
          deleteRecipesNotInPosts(posts: posts)
        }
      }
    } catch {
      print("Could not load posts: \(error)")
    }
  }
  
  @MainActor
  fileprivate func insertRecipe(_ post: Post) {
    let recipe = createRecipe(post)
    
    container.mainContext.insert(recipe)
  }
  
  @MainActor
  fileprivate func updateRecipe(post: Post, existingRecipe: Recipe) {
    let recipe = createRecipe(post)
    
    existingRecipe.name = recipe.name
    existingRecipe.images = recipe.images
    existingRecipe.ingredients = recipe.ingredients
    existingRecipe.instructions = recipe.instructions
    existingRecipe.category = recipe.category
    
    try! container.mainContext.save()
  }
  
  @MainActor
  private func deleteRecipesNotInPosts(posts: [Post]) {
    do {
      let allRecipes = try container.mainContext.fetch(FetchDescriptor<Recipe>())
      let postIDs = posts.map { $0.id }
      for recipe in allRecipes {
        if !postIDs.contains(recipe.id) {
          container.mainContext.delete(recipe)
        }
      }
      try container.mainContext.save()
    } catch {
      print("Failed to delete recipes not in posts: \(error)")
    }
  }
  
  fileprivate func createRecipe(_ post: Post) -> Recipe {
    let categoryImage = getCategoryAssetName(for: post.category.name)
    let category = Category(name: post.category.name, image: categoryImage)
    
    let ingredients = post.ingredients.map { postIngredient in
      Ingredient(name: postIngredient.ingredient.name, unit: postIngredient.unit, quantity: postIngredient.qty)
    }
    
    return Recipe(id: post.id, name: post.name, images: post.pictures.map{String($0)}, ingredients: ingredients, instructions: post.instructions, category: category, isFavorite: false, menuItems: [])
  }
  
}
