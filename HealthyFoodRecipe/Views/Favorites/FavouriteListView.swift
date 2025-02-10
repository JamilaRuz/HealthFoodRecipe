//
//  FavouritesView.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 3/21/24.
//

import SwiftUI
import SwiftData

struct FavouriteListView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.modelContext) var modelContext
    @Query private var recipes: [Recipe]
    @Query private var menuItems: [MenuItem]
    let emptyText: String
    
    var favorites: [Recipe] {
        recipes.filter {$0.isFavorite}
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if favorites.isEmpty {
                    EmptyFavouriteListView(emptyText: "Нет избранных рецептов. Добавьте их, чтобы они появились здесь.")
                        .font(.title)
                        .foregroundColor(.secondary)
                } else {
                    List {
                        ForEach(favorites, id: \.self) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                RecipeListRowView(recipe: recipe, menuItems: menuItems)
                            }
                            .listRowBackground(colorScheme == .dark ? Color(.systemGray6) : Color(.systemBackground))
                        }
                    }
                    .listStyle(.insetGrouped)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .pinkGradientBackground(colorScheme: colorScheme)
            .navigationTitle("Избранное")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
    
    #Preview {
        FavouriteListView(emptyText: "No favorite recipes yet. Please, choose your recipe first.")
            .modelContainer(for: Recipe.self, inMemory: false)
    }
