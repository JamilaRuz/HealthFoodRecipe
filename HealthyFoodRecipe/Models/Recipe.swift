//
//  Recipe.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 3/25/24.
//

import Foundation
import SwiftData

@Model
final class Recipe: Identifiable {
  @Attribute(.unique)
  var id: Int
  var name: String
  @Attribute(.externalStorage)
  var images: [String]
  var ingredients: String
  var instructions: String
  var category: Category
  var isFavorite: Bool
  
  init(id: Int, name: String, images: [String], ingredients: String, instructions: String, category: Category, isFavorite: Bool) {
    self.id = id
    self.name = name
    self.images = images
    self.ingredients = ingredients
    self.instructions = instructions
    self.category = category
    self.isFavorite = isFavorite
  }
}

struct Category: Codable, Hashable {
  var name: String
  var image: String
}
