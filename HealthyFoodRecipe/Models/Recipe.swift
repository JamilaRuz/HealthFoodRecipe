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
    let name: String
    let image: String
    let ingredients: [String]
    let directions: String
    let category: Category.RawValue
    let datePublished: String
    
    init(name: String, image: String, ingredients: [String], directions: String, category: Category.RawValue, datePublished: String) {
        self.name = name
        self.image = image
        self.ingredients = ingredients
        self.directions = directions
        self.category = category
        self.datePublished = datePublished
    }
}

let recipes: [Recipe] = [
    Recipe(
        name: "Strawberry Chia Seed Pudding",
        image: "https://www.bowlofdelicious.com/wp-content/uploads/2014/03/strawberry-chia-pudding-3.jpg",
        ingredients: [
        "sliced fresh strawberries",
        "orange juice",
        "milk",
        "chia seeds",
        "2 tablespoons pure maple syrup",
        "1 teaspoon pure vanilla extract"],
        directions:
        "In a medium saucepan combine 3 cups of the strawberries and the orange juice. Mash until berries are coarsely chopped. Cook over medium until mixture has a jam-like consistency, about 20 minutes. Cool 15 minutes. In a medium bowl whisk together milk, chia seeds, maple syrup, and vanilla. Stir in cooked strawberries. Cover and chill at least 3 hours or overnight. Spoon pudding and the remaining 3 cups fresh strawberries into serving dishes or glasses.",
        category: "Drinks",
        datePublished: "2023-08-07"
    ),
    Recipe(
        name: "Crunchy Hash Brown Waffles with Applesauce",
        image: "https://www.bowlofdelicious.com/wp-content/uploads/2014/03/strawberry-chia-pudding-3.jpg",
        ingredients: [
            "12-oz. package extra-firm tofu, drained",
        "3 tablespoons lemon juice",
        "1 tablespoon white wine vinegar",
        "¾ teaspoon sea salt",
        "¼ teaspoon yellow mustard",
        ],
        directions: "For Tofu Sour Cream, in a blender combine tofu, lemon juice, white wine vinegar; ½ teaspoon sea salt, and the yellow mustard. Cover and blend until smooth and creamy. Refrigerate until ready to use. Preheat oven to 250°F. Place a cooling rack inside a baking sheet. In a food processor combine potatoes, carrot, and cabbage; pulse until finely chopped. Transfer chopped vegetables to a large nonstick skillet; cook over medium-low about 5 minutes or until potatoes are almost tender, stirring occasionally.",
        category: "Breakfasts",
        datePublished: "2023-08-07"
    ),
    Recipe(
        name: "Strawberry-Radish Salad",
        image: "https://www.bowlofdelicious.com/wp-content/uploads/2014/03/strawberry-chia-pudding-3.jpg",
        ingredients: [
            "¼ of a 12.3-oz. package firm silken- style tofu (⅓ cup)",
            "½ teaspoon lemon zest",
            "2 tablespoons lemon juice",
            "¼ teaspoon sea salt",
            "⅛ teaspoon freshly ground black pepper",
            "¼ cup finely chopped shallot"
        ],
        directions: "For dressing, in a medium bowl combine the first five ingredients (through pepper) and 2 tablespoons water. Blend with an immersion blender or in a mini food processor until smooth. Stir in shallot. Let stand at room temperature 15 minutes to let flavors blend.",
        category: "Salads",
        datePublished: "2023-08-07"
    ),
    Recipe(
        name: "Energy Balls and Bars",
        image: "https://feelgoodfoodie.net/wp-content/uploads/2019/02/No-Bake-Energy-Bites-4-1.jpg",
        ingredients: [
            "2 cups dried Mission figs",
            "1 tablespoon lemon juice",
            "2 teaspoon pure vanilla extract",
            "1½ cups gluten-free oat flour",
            "1 cup almond flour",
            "1 cup pitted dates",
            "¾ cup raw cashews"
        ],
        directions: "Preheat oven to 350°F. Line a 2-quart square baking dish with parchment paper. For filling, in a small saucepan combine figs and 1 cup water. Bring to boiling; reduce heat. Cover and simmer 10 minutes or until figs are soft. Transfer figs and cooking liquid to a blender or food processor. Add lemon juice and vanilla. Cover and blend until smooth.",
        category: "Appetizers",
        datePublished: "2023-08-07"
    ),
    Recipe(
        name: "Creamy Spinach and Artichoke Soup",
        image: "https://mypureplants.com/wp-content/uploads/2019/03/cream-of-spinach-soup-vegan-4.jpg",
        ingredients: [
            "2 cups dried Mission figs",
            "1 tablespoon lemon juice",
            "2 teaspoon pure vanilla extract",
            "1½ cups gluten-free oat flour",
            "1 cup almond flour",
            "1 cup pitted dates",
            "¾ cup raw cashews"
        ],
        directions: "Preheat oven to 350°F. Line a 2-quart square baking dish with parchment paper. For filling, in a small saucepan combine figs and 1 cup water. Bring to boiling; reduce heat. Cover and simmer 10 minutes or until figs are soft. Transfer figs and cooking liquid to a blender or food processor. Add lemon juice and vanilla. Cover and blend until smooth.",
        category: "Soups",
        datePublished: "2023-08-07"
    ),
    Recipe(
        name: "Creamy Spinach and Artichoke Soup",
        image: "https://mypureplants.com/wp-content/uploads/2019/03/cream-of-spinach-soup-vegan-4.jpg",
        ingredients: [
            "2 cups dried Mission figs",
            "1 tablespoon lemon juice",
            "2 teaspoon pure vanilla extract",
            "1½ cups gluten-free oat flour",
            "1 cup almond flour",
            "1 cup pitted dates",
            "¾ cup raw cashews"
        ],
        directions: "Preheat oven to 350°F. Line a 2-quart square baking dish with parchment paper. For filling, in a small saucepan combine figs and 1 cup water. Bring to boiling; reduce heat. Cover and simmer 10 minutes or until figs are soft. Transfer figs and cooking liquid to a blender or food processor. Add lemon juice and vanilla. Cover and blend until smooth.",
        category: "Main",
        datePublished: "2023-08-07"
    ),
    Recipe(
        name: "Creamy Spinach and Artichoke Soup",
        image: "https://mypureplants.com/wp-content/uploads/2019/03/cream-of-spinach-soup-vegan-4.jpg",
        ingredients: [
            "2 cups dried Mission figs",
            "1 tablespoon lemon juice",
            "2 teaspoon pure vanilla extract",
            "1½ cups gluten-free oat flour",
            "1 cup almond flour",
            "1 cup pitted dates",
            "¾ cup raw cashews"
        ],
        directions: "Preheat oven to 350°F. Line a 2-quart square baking dish with parchment paper. For filling, in a small saucepan combine figs and 1 cup water. Bring to boiling; reduce heat. Cover and simmer 10 minutes or until figs are soft. Transfer figs and cooking liquid to a blender or food processor. Add lemon juice and vanilla. Cover and blend until smooth.",
        category: "Desserts",
        datePublished: "2023-08-07"
    ),
    Recipe(
        name: "Creamy Spinach and Artichoke Soup",
        image: "https://mypureplants.com/wp-content/uploads/2019/03/cream-of-spinach-soup-vegan-4.jpg",
        ingredients: [
            "2 cups dried Mission figs",
            "1 tablespoon lemon juice",
            "2 teaspoon pure vanilla extract",
            "1½ cups gluten-free oat flour",
            "1 cup almond flour",
            "1 cup pitted dates",
            "¾ cup raw cashews"
        ],
        directions: "Preheat oven to 350°F. Line a 2-quart square baking dish with parchment paper. For filling, in a small saucepan combine figs and 1 cup water. Bring to boiling; reduce heat. Cover and simmer 10 minutes or until figs are soft. Transfer figs and cooking liquid to a blender or food processor. Add lemon juice and vanilla. Cover and blend until smooth.",
        category: "Side",
        datePublished: "2023-08-07"
    )
]
