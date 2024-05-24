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
  case "Ужины":
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
