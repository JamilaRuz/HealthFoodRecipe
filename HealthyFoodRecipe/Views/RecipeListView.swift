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
        VStack {
            List() {
                ForEach(recipes.filter {$0.category == category}, id: \.self) { recipe in
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
//                                    .baselineOffset(15)
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
        .background {
            Color.blue.opacity(0.1)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    RecipeListView(category: "Cake")
        .modelContainer(for: MenuItem.self, inMemory: true)
}
