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
//    let id = UUID()
    var name: String
    var image: String
    var ingredients: [Ingredient]
    var directions: String
    var category: Category
    var isFavorite: Bool
    var menuItems: [MenuItem]?
    
    init(name: String, image: String, ingredients: [Ingredient], directions: String, category: Category, isFavorite: Bool, menuItems: [MenuItem]) {
        self.name = name
        self.image = image
        self.ingredients = ingredients
        self.directions = directions
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
