//
//  RecipeDetails.swift
//  HealthFoodRecipe
//
//  Created by Jamila Ruzimetova on 3/20/24.
//

import SwiftUI
import SwiftData

struct RecipeDetails: View {
    @Environment(\.modelContext) var modelContext
    @Query private var menuItems: [MenuItem]
    @State private var isFavorited = false
    
    @Bindable var recipe: Recipe
    
    @State var selectedDay = Day.Monday
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        ScrollView {
            VStack {
                Image(recipe.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } //image
            .frame(height: 300)
            .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
            
            VStack(spacing: 30) {
                Text(recipe.name)
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Ingredients")
                            .font(.headline)
                        Spacer()
                        Button(action: {
                            isFavorited.toggle()
                            recipe.isFavorite = isFavorited
                        }) {
                            Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                                .resizable()
                                .tint(Color.pink)
                                .frame(width: 30, height: 30)
                        }
                    }
                        
                    ForEach(recipe.ingredients, id: \.name) { ingredient in
                        HStack(spacing: 10) {
                            Text("- \(ingredient.name)")
                            Text(String(format: "%g", ingredient.quantity))
                            Text("(\(ingredient.unit))")
                        }
                    }
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Instructions")
                            .font(.headline)
                        Text(recipe.directions)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Picker("Select a day to add to the menu", selection: $selectedDay) {
                        ForEach(Day.allCases, id: \.self) {
                            Text($0.rawValue).tag($0)
                        }
                    }
                    
                    Button(action: {
                        let thisMenuItem = MenuItem(recipeName: recipe.name, day: selectedDay.rawValue)
                        modelContext.insert(thisMenuItem)
                        
                        dismiss()
                    }) {
                        Text("Add to weekly menu")
                            .padding()
                    }
                }
            }
            .padding(.horizontal, 40)// why is it so big
        }
        .ignoresSafeArea(.container, edges: .top)
    }
    
    
}

#Preview {
    RecipeDetails(recipe: 
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
    )
)
        .modelContainer(for: MenuItem.self, inMemory: true)
 
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true) // Store the container in memory since we don't actually want to save the preview data
//        let container = try ModelContainer(for: Recipe.self, configurations: config)
//        
//        return RecipeDetails(recipe: recipes[0])
//            .modelContainer(container)
//    } catch {
//        return Text("Failed to create preview: \(error.localizedDescription)")
//    }
}
