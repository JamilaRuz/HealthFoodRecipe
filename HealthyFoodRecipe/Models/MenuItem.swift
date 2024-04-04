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
    var recipeName: String?
    var day: String?
    var isChecked: Bool
    
    init(recipeName: String, day: String, isChecked: Bool = false) {
        self.recipeName = recipeName
        self.day = day
        self.isChecked = isChecked
    }
}
