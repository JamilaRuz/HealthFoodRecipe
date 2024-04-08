//
//  MenuItem.swift
//  HealthFoodRecipe
//
//  Created by Jamila Ruzimetova on 3/19/24.
//

import Foundation
import SwiftData

@Model
final class MenuItem {
    var day: String?
    var isChecked: Bool
    
    @Relationship(deleteRule: .cascade, inverse: \Recipe.menuItems)
    var recipe: Recipe?
    
    init(day: String, isChecked: Bool, recipe: Recipe) {
        self.day = day
        self.isChecked = isChecked
        self.recipe = recipe
    }
}
