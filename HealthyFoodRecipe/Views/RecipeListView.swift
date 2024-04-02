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
    @Query private var recipes: [Recipe]
    @State private var searchTerm = ""
    
    var filteredRecipes: [Recipe] {
        let categoryFiltered = recipes.filter {$0.category == category}
        guard !searchTerm.isEmpty else { return categoryFiltered }
        return categoryFiltered.filter { $0.name.localizedCaseInsensitiveContains(searchTerm)}
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List() {
                    ForEach(filteredRecipes, id: \.self) { recipe in
                        NavigationLink(destination: RecipeDetails(recipe: recipe)) {
                            HStack {
                                Image("meat")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 80)
                                    .cornerRadius(5)
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(recipe.name)
                                        .font(.headline)
                                        .bold()
                                    Text(recipe.name)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
                .background(Color.white)
                .listStyle(.grouped)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .cornerRadius(10)
            .navigationTitle("Recipes")
            .searchable(text: $searchTerm, prompt: "Search recipe")
        }
    }
}

#Preview {
    RecipeListView(category: "Cake")
        .modelContainer(for: MenuItem.self, inMemory: true)
}
