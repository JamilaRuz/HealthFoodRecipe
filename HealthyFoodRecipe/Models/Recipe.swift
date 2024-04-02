//
//  Recipe.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 3/25/24.
//

import Foundation
import SwiftData

enum Category: String {
    case breakfast = "Breakfast"
    case soup = "Soups"
    case salad = "Salads"
    case appetizers = "Appetizers"
    case main = "Main"
    case side = "Side"
    case dessert = "Dessert"
    case drink = "Drinks"
}

@Model
class Recipe: Identifiable {
    let id = UUID()
    var name: String
    var image: String
    var ingredients: [Ingredient]
    var directions: String
    var category: Category.RawValue
    var isFavorite: Bool
    
    init(name: String, image: String, ingredients: [Ingredient], directions: String, category: Category.RawValue, isFavorite: Bool) {
        self.name = name
        self.image = image
        self.ingredients = ingredients
        self.directions = directions
        self.category = category
        self.isFavorite = isFavorite
    }
}

struct Ingredient: Codable {
    var name: String
    var unit: String
    var quantity: Float
}
