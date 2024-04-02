//
//  HealthFoodRecipeApp.swift
//  HealthFoodRecipe
//
//  Created by Jamila Ruzimetova on 3/19/24.
//

import SwiftUI
import SwiftData

@main
@MainActor
struct HealthyFoodRecipeApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            MenuItem.self, Recipe.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)

        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            let recipes: [Recipe] = [
                Recipe(
                    name: "Strawberry Chia Seed Pudding",
                    image: "dessert",
                    ingredients:
                        [Ingredient(name: "extra-firm tofu, drained", unit: "package", quantity: 12), Ingredient(name: "lemon juice", unit: "tbs", quantity: 3),
                            Ingredient(name: "white wine vinegar", unit: "tbs", quantity: 1),
                            Ingredient(name: "yellow mustard", unit: "ts", quantity: 0.25)],
                    directions:
                    "In a medium saucepan combine 3 cups of the strawberries and the orange juice. Mash until berries are coarsely chopped. Cook over medium until mixture has a jam-like consistency, about 20 minutes. Cool 15 minutes. In a medium bowl whisk together milk, chia seeds, maple syrup, and vanilla. Stir in cooked strawberries. Cover and chill at least 3 hours or overnight. Spoon pudding and the remaining 3 cups fresh strawberries into serving dishes or glasses.",
                    category: "Drinks",
                    isFavorite: false
                ),
                Recipe(
                    name: "Crunchy Hash Brown Waffles with Applesauce",
                    image: "dish",
                    ingredients:
                        [Ingredient(name: "extra-firm tofu, drained", unit: "package", quantity: 12), Ingredient(name: "lemon juice", unit: "tbs", quantity: 3), Ingredient(name: "white wine vinegar", unit: "tbs", quantity: 1), Ingredient(name: "yellow mustard", unit: "ts", quantity: 0.25)],
                    directions: "For Tofu Sour Cream, in a blender combine tofu, lemon juice, white wine vinegar; ½ teaspoon sea salt, and the yellow mustard. Cover and blend until smooth and creamy. Refrigerate until ready to use. Preheat oven to 250°F. Place a cooling rack inside a baking sheet. In a food processor combine potatoes, carrot, and cabbage; pulse until finely chopped. Transfer chopped vegetables to a large nonstick skillet; cook over medium-low about 5 minutes or until potatoes are almost tender, stirring occasionally.",
                    category: "Breakfasts",
                    isFavorite: false
                ),
                Recipe(
                    name: "Fried eggs with avocado",
                    image: "salad",
                    ingredients:
                        [Ingredient(name: "extra-firm tofu, drained", unit: "package", quantity: 12), Ingredient(name: "lemon juice", unit: "tbs", quantity: 3), Ingredient(name: "white wine vinegar", unit: "tbs", quantity: 1), Ingredient(name: "yellow mustard", unit: "ts", quantity: 0.25)],
                    directions: "For Tofu Sour Cream, in a blender combine tofu, lemon juice, white wine vinegar; ½ teaspoon sea salt, and the yellow mustard. Cover and blend until smooth and creamy. Refrigerate until ready to use. Preheat oven to 250°F. Place a cooling rack inside a baking sheet. In a food processor combine potatoes, carrot, and cabbage; pulse until finely chopped. Transfer chopped vegetables to a large nonstick skillet; cook over medium-low about 5 minutes or until potatoes are almost tender, stirring occasionally.",
                    category: "Breakfasts",
                    isFavorite: false
                ),
                Recipe(
                    name: "Toast with coffee",
                    image: "appetizers",
                    ingredients:
                        [Ingredient(name: "extra-firm tofu, drained", unit: "package", quantity: 12), Ingredient(name: "lemon juice", unit: "tbs", quantity: 3), Ingredient(name: "white wine vinegar", unit: "tbs", quantity: 1), Ingredient(name: "yellow mustard", unit: "ts", quantity: 0.25)],
                    directions: "For Tofu Sour Cream, in a blender combine tofu, lemon juice, white wine vinegar; ½ teaspoon sea salt, and the yellow mustard. Cover and blend until smooth and creamy. Refrigerate until ready to use. Preheat oven to 250°F. Place a cooling rack inside a baking sheet. In a food processor combine potatoes, carrot, and cabbage; pulse until finely chopped. Transfer chopped vegetables to a large nonstick skillet; cook over medium-low about 5 minutes or until potatoes are almost tender, stirring occasionally.",
                    category: "Breakfasts",
                    isFavorite: false
                ),
                Recipe(
                    name: "Strawberry-Radish Salad",
                    image: "dessert",
                    ingredients:
                        [Ingredient(name: "extra-firm tofu, drained", unit: "package", quantity: 12), Ingredient(name: "lemon juice", unit: "tbs", quantity: 3), Ingredient(name: "white wine vinegar", unit: "tbs", quantity: 1), Ingredient(name: "yellow mustard", unit: "ts", quantity: 0.25)],

                    directions: "For dressing, in a medium bowl combine the first five ingredients (through pepper) and 2 tablespoons water. Blend with an immersion blender or in a mini food processor until smooth. Stir in shallot. Let stand at room temperature 15 minutes to let flavors blend.",
                    category: "Salads",
                    isFavorite: false
                ),
                Recipe(
                    name: "Energy Balls and Bars",
                    image: "soup",
                    ingredients:
                        [Ingredient(name: "extra-firm tofu, drained", unit: "package", quantity: 12), Ingredient(name: "lemon juice", unit: "tbs", quantity: 3), Ingredient(name: "white wine vinegar", unit: "tbs", quantity: 1), Ingredient(name: "yellow mustard", unit: "ts", quantity: 0.25)],
                    directions: "Preheat oven to 350°F. Line a 2-quart square baking dish with parchment paper. For filling, in a small saucepan combine figs and 1 cup water. Bring to boiling; reduce heat. Cover and simmer 10 minutes or until figs are soft. Transfer figs and cooking liquid to a blender or food processor. Add lemon juice and vanilla. Cover and blend until smooth.",
                    category: "Appetizers",
                    isFavorite: false
                ),
                Recipe(
                    name: "Creamy Spinach and Artichoke Soup",
                    image: "salad",
                    ingredients:
                        [Ingredient(name: "extra-firm tofu, drained", unit: "package", quantity: 12), Ingredient(name: "lemon juice", unit: "tbs", quantity: 3), Ingredient(name: "white wine vinegar", unit: "tbs", quantity: 1), Ingredient(name: "yellow mustard", unit: "ts", quantity: 0.25)],
                    directions: "Preheat oven to 350°F. Line a 2-quart square baking dish with parchment paper. For filling, in a small saucepan combine figs and 1 cup water. Bring to boiling; reduce heat. Cover and simmer 10 minutes or until figs are soft. Transfer figs and cooking liquid to a blender or food processor. Add lemon juice and vanilla. Cover and blend until smooth.",
                    category: "Soups",
                    isFavorite: false
                ),
                Recipe(
                    name: "Creamy Spinach and Artichoke Soup",
                    image: "dish",
                    ingredients:
                        [Ingredient(name: "extra-firm tofu, drained", unit: "package", quantity: 12), Ingredient(name: "lemon juice", unit: "tbs", quantity: 3), Ingredient(name: "white wine vinegar", unit: "tbs", quantity: 1), Ingredient(name: "yellow mustard", unit: "ts", quantity: 0.25)],
                    directions: "Preheat oven to 350°F. Line a 2-quart square baking dish with parchment paper. For filling, in a small saucepan combine figs and 1 cup water. Bring to boiling; reduce heat. Cover and simmer 10 minutes or until figs are soft. Transfer figs and cooking liquid to a blender or food processor. Add lemon juice and vanilla. Cover and blend until smooth.",
                    category: "Main",
                    isFavorite: true
                ),
                Recipe(
                    name: "Creamy Spinach and Artichoke Soup",
                    image: "meat",
                    ingredients:
                        [Ingredient(name: "extra-firm tofu, drained", unit: "package", quantity: 12), Ingredient(name: "lemon juice", unit: "tbs", quantity: 3), Ingredient(name: "white wine vinegar", unit: "tbs", quantity: 1), Ingredient(name: "yellow mustard", unit: "ts", quantity: 0.25)],
                    directions: "Preheat oven to 350°F. Line a 2-quart square baking dish with parchment paper. For filling, in a small saucepan combine figs and 1 cup water. Bring to boiling; reduce heat. Cover and simmer 10 minutes or until figs are soft. Transfer figs and cooking liquid to a blender or food processor. Add lemon juice and vanilla. Cover and blend until smooth.",
                    category: "Desserts",
                    isFavorite: false
                ),
                Recipe(
                    name: "Creamy Spinach and Artichoke Soup",
                    image: "garnish",
                    ingredients:
                        [Ingredient(name: "extra-firm tofu, drained", unit: "package", quantity: 12), Ingredient(name: "lemon juice", unit: "tbs", quantity: 3), Ingredient(name: "white wine vinegar", unit: "tbs", quantity: 1), Ingredient(name: "yellow mustard", unit: "ts", quantity: 0.25)],
                    directions: "Preheat oven to 350°F. Line a 2-quart square baking dish with parchment paper. For filling, in a small saucepan combine figs and 1 cup water. Bring to boiling; reduce heat. Cover and simmer 10 minutes or until figs are soft. Transfer figs and cooking liquid to a blender or food processor. Add lemon juice and vanilla. Cover and blend until smooth.",
                    category: "Side",
                    isFavorite: true
                )
            ]
            
            for recipe in recipes {
                container.mainContext.insert(recipe)
            }
            
            return container

//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
