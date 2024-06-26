//
//  DataImporter.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 5/25/24.
//

import SwiftUI
import SwiftData
import CoreData


class DataImporter {
  
  private let modelContext: ModelContext
  
  private let lastChangeTimeKey = "LastChangeTime"
  
  private let postLoader = PostLoader()
  
  init(modelContext: ModelContext) {
    self.modelContext = modelContext
  }
  
  @MainActor
  func importData() async {
    do {
      let lastChangeTimeFromServer = try await postLoader.getLastChangeTimeFromServer()
      let lastChangeTimeFromApp = getLastChangeTimeFromApp()
      if lastChangeTimeFromServer == lastChangeTimeFromApp {
        return
      }
      
      let posts = try await postLoader.loadPosts()
      if !posts.isEmpty {
        posts.forEach { post in
          let id = post.id
          let descriptor = FetchDescriptor<Recipe>(predicate: #Predicate { $0.id == id })
          let foundRecipes = (try? modelContext.fetch(descriptor)) ?? [Recipe]()
          
          if foundRecipes.count == 0 {
            insertRecipe(post)
          } else {
            updateRecipe(post: post, existingRecipe: foundRecipes[0])
          }
          
          deleteRecipesNotInPosts(posts: posts)
        }
        
        saveLastChangeTimeToApp(lastChangeTimeFromServer)
      }
    } catch {
      print("Could not load posts: \(error)")
    }
  }
  
  @MainActor
  fileprivate func insertRecipe(_ post: Post) {
    let recipe = createRecipe(post)
    
    modelContext.insert(recipe)
  }
  
  @MainActor
  fileprivate func updateRecipe(post: Post, existingRecipe: Recipe) {
    let recipe = createRecipe(post)
    
    existingRecipe.name = recipe.name
    existingRecipe.images = recipe.images
    existingRecipe.ingredients = recipe.ingredients
    existingRecipe.instructions = recipe.instructions
    existingRecipe.category = recipe.category
    
    try! modelContext.save()
  }
  
  @MainActor
  private func deleteRecipesNotInPosts(posts: [Post]) {
    do {
      let allRecipes = try modelContext.fetch(FetchDescriptor<Recipe>())
      let postIDs = posts.map { $0.id }
      for recipe in allRecipes {
        if !postIDs.contains(recipe.id) {
          modelContext.delete(recipe)
        }
      }
      try modelContext.save()
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
    
    return Recipe(id: post.id, name: post.name, images: post.pictures, ingredients: ingredients, instructions: post.instructions, category: category, isFavorite: false, menuItems: [])
  }
  
  private func saveLastChangeTimeToApp(_ lastChangeTime: String) {
    UserDefaults.standard.set(lastChangeTime, forKey: lastChangeTimeKey)
  }
  
  private func getLastChangeTimeFromApp() -> String {
    return UserDefaults.standard.string(forKey: lastChangeTimeKey) ?? ""
  }
}
