//
//  RecipeListView.swift
//  HealthFoodRecipe
//
//  Created by Jamila Ruzimetova on 3/20/24.
//

import SwiftUI
import SwiftData

struct RecipeListView: View {
    var category: Category
    
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
                Text("\(filteredRecipes.count) рецептов")
                    .font(.title)
                    .fontWeight(.semibold)
                List() {
                    ForEach(filteredRecipes, id: \.self) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            HStack {
                                AsyncImage(url: URL(string: recipe.images.first ?? "")) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(width: 100, height: 80)
                                            .background(Color.gray.opacity(0.2))
                                            .cornerRadius(5)
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 80)
                                            .cornerRadius(5)
                                    case .failure:
                                        Image("placeholderImg")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 80)
                                            .cornerRadius(5)
                                    @unknown default:
                                        Image("placeholderImg")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 80)
                                            .cornerRadius(5)
                                    }
                                }
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(recipe.name)
                                        .font(.system(size: 18, weight: .medium))
                                    
                                    let allIngreds = recipe.ingredients.map{$0.name}.joined(separator: ", ")
                                    Text(allIngreds)
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray)
                                        .lineLimit(2)
                                    
                                    HStack {
                                        if recipe.isFavorite {
                                            Image(systemName: "heart.fill")
                                                .foregroundColor(.accentColor)
                                        }
                                        if !(recipe.menuItems?.isEmpty ?? true) {
                                            Image(systemName: "menucard.fill")
                                                .foregroundColor(.purple)
                                        }
                                    }
                                }
                                .padding(.horizontal, 5)
                            }
                        }
                    }
                }
                .background(Color.white)
                .listStyle(.grouped)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .cornerRadius(10)
            .navigationTitle("Рецепты")
            .searchable(text: $searchTerm, prompt: "Поиск рецептов")
        }
    }
}

#Preview {
    RecipeListView(category: Category(name: "Breakfasts", image: "breakfast1"))
    .modelContainer(for: Recipe.self, inMemory: true)
}
