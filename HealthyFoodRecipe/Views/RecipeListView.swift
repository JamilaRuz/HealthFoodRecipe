//
//  RecipeListView.swift
//  HealthFoodRecipe
//
//  Created by Jamila Ruzimetova on 3/20/24.
//

import SwiftUI
import SwiftData

struct RecipeListView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var menuItems: [MenuItem]
    
    var body: some View {
        NavigationView {
            List() {
                ForEach(recipes, id: \.self) { thisRecipe in
                    NavigationLink(destination: RecipeDetails(thisRecipe: thisRecipe)) {
                        Text(thisRecipe.Title ?? "")
                    }
                }
            }
            .navigationTitle("Recipes")
        }
    }
}

#Preview {
    RecipeListView()
        .modelContainer(for: MenuItem.self, inMemory: true)
}
