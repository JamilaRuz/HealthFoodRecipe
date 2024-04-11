//
//  RecipeDetails.swift
//  HealthFoodRecipe
//
//  Created by Jamila Ruzimetova on 3/20/24.
//

import SwiftUI
import SwiftData



struct RecipeDetailView: View {
    @Query private var menuItems: [MenuItem]
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    @State private var isFavorited = false
    @State private var isSelecting = false
    @State var selectedDay = Day.Monday
    @Bindable var recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack {
                Image(recipe.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .clipped()
            } //image
            .frame(height: 300)
            .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
            
            VStack(spacing: 15) {
                Text(recipe.name)
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                
                VStack(alignment: .leading, spacing: 5) {
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
                                .tint(Color.lightPurple)
                                .frame(width: 30, height: 30)
                        }
                    }
                        
                    let columns = [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ]
                    
                    LazyVGrid(columns: columns, spacing: 5) {
                        ForEach(recipe.ingredients, id: \.name) { ingredient in
                            Text("\(String(format: "%g", ingredient.quantity)) (\(ingredient.unit)) -")
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            Text("\(ingredient.name)")
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .multilineTextAlignment(.leading)
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
                
                VStack(spacing: 0) {
                    Text("Select a day to add to the menu")
                        .foregroundColor(.gray)
                        .font(.caption2)
                    
                    Picker("Select a day to add to the menu", selection: $selectedDay) {
                        ForEach(Day.allCases, id: \.self) {
                            Text($0.rawValue).tag($0)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    Button(action: {
                        let thisMenuItem = MenuItem(day: selectedDay.rawValue, isChecked: false, recipe: recipe)
                        modelContext.insert(thisMenuItem)
                        
                        dismiss()
                    }) {
                        Text("Add to menu")
                            .frame(width: 150, height: 50)
                            .background(LinearGradient(colors: [.purple, .lightPurple], startPoint: .top, endPoint: .bottom))
                            .foregroundColor(.white)
                            .font(.body)
                            .bold()
                            .cornerRadius(10)
                            .padding(15)
                    }
                }
            }
            .padding(.horizontal, 10)// why is it so big
        }
        .ignoresSafeArea(.container, edges: .top)
    }
    
    
}

#Preview {
    RecipeDetailView(recipe: 
                    Recipe(
                        name: "Strawberry Chia Seed Pudding",
                        image: "dish1",
                        ingredients:
                            [Ingredient(name: "extra-firm tofu, drained somethig somewhere", unit: "pkg", quantity: 12), Ingredient(name: "lemon juice", unit: "tbs", quantity: 3),
                             Ingredient(name: "white wine vinegar", unit: "tbs", quantity: 1),
                             Ingredient(name: "yellow mustard", unit: "ts", quantity: 0.25)],
                        directions:
                        "In a medium saucepan combine 3 cups of the strawberries and the orange juice. Mash until berries are coarsely chopped. Cook over medium until mixture has a jam-like consistency, about 20 minutes. Cool 15 minutes. In a medium bowl whisk together milk, chia seeds, maple syrup, and vanilla. Stir in cooked strawberries. Cover and chill at least 3 hours or overnight. Spoon pudding and the remaining 3 cups fresh strawberries into serving dishes or glasses.",
                        category: Category(name: "Напитки", image: "drink"),
                        isFavorite: false,
                        menuItems: []
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