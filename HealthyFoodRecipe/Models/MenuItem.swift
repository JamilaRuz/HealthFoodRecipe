//
//  MenuItem.swift
//  HealthFoodRecipe
//
//  Created by Jamila Ruzimetova on 3/19/24.
//

import Foundation
import SwiftData

@Model
final class MenuItem: Identifiable {
  @Attribute(.unique) var id: String
  var day: String
  var isChecked: Bool
  var recipe: Recipe?  // Remove @Relationship since it's not needed
  
  init(day: String, isChecked: Bool = false, recipe: Recipe? = nil) {
    self.id = UUID().uuidString
    self.day = day
    self.isChecked = isChecked
    self.recipe = recipe
  }
}
