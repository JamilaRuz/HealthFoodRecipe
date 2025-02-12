//
//  RecipeListView.swift
//  HealthFoodRecipe
//
//  Created by Jamila Ruzimetova on 3/20/24.
//

import SwiftUI
import SwiftData

struct RecipeListView: View {
  @Environment(\.colorScheme) var colorScheme
  var category: Category
  
  @Query private var recipes: [Recipe]
  @Query private var menuItems: [MenuItem]
  @State private var searchTerm = ""
  
  var filteredRecipes: [Recipe] {
    let categoryFiltered = recipes.filter {$0.category == category}
    guard !searchTerm.isEmpty else { return categoryFiltered }
    
    return categoryFiltered.filter { $0.name.localizedCaseInsensitiveContains(searchTerm)}
  }
  
  init(category: Category) {
    self.category = category
  }
  
  var body: some View {
    VStack {
      List {
        Section(header: Text("\(category.name) (\(filteredRecipes.count))")) {
          ForEach(filteredRecipes, id: \.self) { recipe in
            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
              RecipeListRowView(recipe: recipe, menuItems: menuItems)
            }
            .listRowBackground(colorScheme == .dark ? Color(.systemGray6) : Color(.systemBackground))
          }
        }
      }
      .listStyle(.insetGrouped)
      .scrollContentBackground(.hidden)
      .background(Color.clear)
      .searchable(
        text: $searchTerm,
        prompt: Text("Поиск рецептов")
            .foregroundColor(Color(.secondaryLabel))
      )
      .tint(colorScheme == .dark ? .gray : Color("green1"))
      .foregroundColor(colorScheme == .dark ? .gray : .black)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .pinkGradientBackground(colorScheme: colorScheme)
    .navigationTitle("Рецепты")
    .navigationBarTitleDisplayMode(.inline)
  }
}

#Preview {
  RecipeListView(category: createStubRecipes()[0].category)
    .environment(\.modelContext, createPreviewModelContainer().mainContext)
}
