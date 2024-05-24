//
//  FavouritesView.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 3/21/24.
//

import SwiftUI
import SwiftData

struct FavouriteListView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var recipes: [Recipe]
    let emptyText: String
    
    var favorites: [Recipe] {
        recipes.filter {$0.isFavorite}
    }
    
    var body: some View {
        NavigationStack {
            if favorites.isEmpty {
                EmptyFavouriteListView(emptyText: "Нет избранных рецептов. Добавьте их, чтобы они появились здесь.")
                    .font(.title)
                    .foregroundColor(.gray)
            } else {
                VStack {
                    List() {
                        ForEach(favorites, id: \.self) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                RecipeListRowView(recipe: recipe)
                            }
                        }
                    }
                    
                    .background(Color.white)
                    .listStyle(.grouped)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .cornerRadius(10)
                .navigationTitle("Избранное")
                .navigationBarTitleDisplayMode(.inline)
                .background(
                    LinearGradient(colors: [.pink2, .pink1, .white], startPoint: .top, endPoint: .bottom)
                )

            }
        }
    }
}
    
    #Preview {
        FavouriteListView(emptyText: "No favorite recipes yet. Please, choose your recipe first.")
            .modelContainer(for: Recipe.self, inMemory: false)
    }
