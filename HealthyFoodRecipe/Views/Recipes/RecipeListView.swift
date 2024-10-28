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
  @Environment(\.colorScheme) var colorScheme
  
  @Query private var recipes: [Recipe]
  @Query private var menuItems: [MenuItem]  // Add this line
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
    NavigationStack {
      VStack(alignment: .leading) {
        List {
          Section(header: Text("\(category.name) (\(filteredRecipes.count))")
            .foregroundColor(colorScheme == .dark ? .white : .black)
          ) {
            ForEach(filteredRecipes, id: \.self) { recipe in
              NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                RecipeListRowView(recipe: recipe, menuItems: menuItems)  // Pass menuItems here
              }
            }
            .padding(.vertical, 5)
            .listRowBackground(
              RoundedRectangle(cornerRadius: 10)
                .fill(colorScheme == .dark ? 
                      Color(UIColor.secondarySystemBackground) : 
                      Color.white)
                .padding(.vertical, 5)
                .shadow(radius: colorScheme == .dark ? 2 : 5)
            )
          }
        }
        .scrollContentBackground(.hidden)
        .cornerRadius(20)
        
        .navigationTitle("Рецепты")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchTerm, prompt: "Поиск рецептов")
      }//nav stack
      .background(
        Group {
          if colorScheme == .dark {
            LinearGradient(
              colors: [Color(red: 0.2, green: 0.1, blue: 0.2), Color.black],
              startPoint: .top,
              endPoint: .bottom
            )
          } else {
            LinearGradient(
              colors: [Color("pink2"), Color("pink1"), .white],
              startPoint: .top,
              endPoint: .bottom
            )
          }
        }
      )
      .accentColor(colorScheme == .dark ? .white : Color("green1"))
    }//body
  }
}

#Preview {
  RecipeListView(category: createStubRecipes()[0].category)
    .environment(\.modelContext, createPreviewModelContainer().mainContext)
}
