//
//  Category.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 4/23/24.
//

import Foundation

func getCategoryAssetName(for category: String) -> String {
  switch category {
  case "Завтраки":
    return "breakfast"
  case "Основные блюда":
    return "lunch"
  case "Ужин":
    return "dinner"
  case "Супы":
    return "soup"
  case "Салаты":
    return "salad"
  case "ПП Выпечка":
    return "baking"
  case "Перекусы":
    return "appetizer"
  case "Десерты":
    return "dessert"
  default:
    return "placeholder"
  }
}

func getAllCategories() -> [Category] {
  [
    Category(name: "Завтраки", image: "breakfast"),
    Category(name: "Основные блюда", image: "lunch"),
    Category(name: "Ужин", image: "dinner"),
    Category(name: "Супы", image: "soup"),
    Category(name: "Салаты", image: "salad"),
    Category(name: "ПП Выпечка", image: "baking"),
    Category(name: "Перекусы", image: "appetizer"),
    Category(name: "Десерты", image: "dessert")
  ]
}
