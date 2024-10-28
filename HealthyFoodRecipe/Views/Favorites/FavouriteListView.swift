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
    let emptyText: String
    
    var favorites: [Recipe] {
        recipes.filter {$0.isFavorite}
    }
    
    var body: some View {
        NavigationStack {
            if favorites.isEmpty {
                EmptyFavouriteListView(emptyText: "Нет избранных рецептов. Добавьте их, чтобы они появились здесь.")
                    .font(.title)
                    .foregroundColor(colorScheme == .dark ? .white : .gray)
            } else {
                VStack {
                    List {
                        ForEach(favorites, id: \.self) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                RecipeListRowView(recipe: recipe)
                            }
                            .listRowBackground(colorScheme == .dark ? Color(UIColor.secondarySystemBackground) : .white)
                        }
                    }
                    .background(Color(UIColor.systemBackground))
                    .listStyle(.grouped)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .cornerRadius(10)
                .navigationTitle("Избранное")
                .navigationBarTitleDisplayMode(.inline)
                .background(
                    colorScheme == .dark ?
                    LinearGradient(colors: [Color(red: 0.2, green: 0.1, blue: 0.2), Color.black], startPoint: .top, endPoint: .bottom) :
                    LinearGradient(colors: [Color("pink2"), Color("pink1"), .white], startPoint: .top, endPoint: .bottom)
                )
            }
        }
        .accentColor(colorScheme == .dark ? .white : Color("green1"))
    }
}
    
    #Preview {
        FavouriteListView(emptyText: "No favorite recipes yet. Please, choose your recipe first.")
            .modelContainer(for: Recipe.self, inMemory: false)
    }
