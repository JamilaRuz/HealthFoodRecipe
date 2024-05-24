//
//  Recipe.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 3/25/24.
//

import Foundation
import SwiftData

@Model
class Recipe: Identifiable {
  @Attribute(.unique)
  let id: Int
  var name: String
  var images: [String]
  var ingredients: [Ingredient]
  var instructions: String
  var category: Category
  var isFavorite: Bool
  var menuItems: [MenuItem]?
  
  init(id: Int, name: String, images: [String], ingredients: [Ingredient], instructions: String, category: Category, isFavorite: Bool, menuItems: [MenuItem]? = nil) {
    self.id = id
    self.name = name
    self.images = images
    self.ingredients = ingredients
    self.instructions = instructions
    self.category = category
    self.isFavorite = isFavorite
    self.menuItems = menuItems
  }
}

struct Ingredient: Codable, Hashable {
  var name: String
  var unit: String
  var quantity: Float
}

struct Category: Codable, Hashable {
  var name: String
  var image: String
}
