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
            ForEach(recipes, id: \.self) { thisRecipe in
                Text(thisRecipe.Title ?? "")
            }
            .navigationTitle("Recipes")
        }
    }
}

#Preview {
    RecipeListView()
        .modelContainer(for: MenuItem.self, inMemory: true)
}
