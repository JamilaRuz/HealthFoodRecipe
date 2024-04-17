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
                EmptyView(emptyText: "Нет избранных рецептов. Добавьте их, чтобы они появились здесь.")
                    .font(.title)
                    .foregroundColor(.gray)
            } else {
                VStack {
                    List() {
                        ForEach(favorites, id: \.self) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                HStack {
                                    Image(recipe.images[0])
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 80)
                                        .cornerRadius(5)
                                    
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text(recipe.name)
                                            .font(.headline)
                                            .bold()
                                        let allIngreds = recipe.ingredients.map{$0.name}.joined(separator: ", ")
                                        Text(allIngreds)
                                            .font(.system(size: 12))
                                            .foregroundColor(.gray)
                                            .lineLimit(2)
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
                .navigationTitle("Избранное")
            }
        }
    }
}
    
    #Preview {
        FavouriteListView(emptyText: "No favorite recipes yet. Please, choose your recipe first.")
            .modelContainer(for: Recipe.self, inMemory: false)
    }
