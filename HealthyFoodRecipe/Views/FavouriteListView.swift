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

    var favorites: [Recipe] {
         recipes.filter {$0.isFavorite}
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List() {
                    ForEach(favorites, id: \.self) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            HStack {
                                Image(recipe.image)
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
            .navigationTitle("Favorites")
        }
    }
}

#Preview {
    FavouriteListView()
        .modelContainer(for: Recipe.self, inMemory: false)
}
