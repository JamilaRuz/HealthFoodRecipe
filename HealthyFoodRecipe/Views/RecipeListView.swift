//
//  RecipeListView.swift
//  HealthFoodRecipe
//
//  Created by Jamila Ruzimetova on 3/20/24.
//

import SwiftUI
import SwiftData

struct RecipeListView: View {
    var category: String
    
    @Environment(\.modelContext) var modelContext
    @Query private var menuItems: [MenuItem]
    
    var body: some View {
        List() {
            ForEach(recipes.filter {$0.Category == category}, id: \.self) { thisRecipe in
                NavigationLink(destination: RecipeDetails(thisRecipe: thisRecipe)) {
                    Text(thisRecipe.Title ?? "")
                }
            }
        }
        .navigationTitle("Recipes")
    }
}

#Preview {
    RecipeListView(category: "Cake")
        .modelContainer(for: MenuItem.self, inMemory: true)
}
