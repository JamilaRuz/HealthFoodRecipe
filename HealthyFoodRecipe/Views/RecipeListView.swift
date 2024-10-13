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
  
  init(category: Category) {
    self.category = category
  }
  
  var body: some View {
    NavigationStack {
      VStack(alignment: .leading) {
        List {
          Section(header: Text("\(category.name) (\(filteredRecipes.count))")) {
            ForEach(filteredRecipes, id: \.self) { recipe in
              NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                RecipeListRowView(recipe: recipe)
              }
            }
            .padding(.vertical, 5)
            .listRowBackground(
              RoundedRectangle(cornerRadius: 10)
                .fill(Color(.white))
                .padding(.vertical, 5)
                .shadow(radius: 5)
            )
          }
        }
        .scrollContentBackground(.hidden)
        //                .background(Color.pink1)
        //                .background(
        //                    LinearGradient(colors: [.pink2, .pink1, .white], startPoint: .top, endPoint: .bottom)
        //                )
        .cornerRadius(20)
        
        .navigationTitle("Рецепты")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchTerm, prompt: "Поиск рецептов")
      }//nav stack
      .background(
        LinearGradient(colors: [.pink2, .pink1, .white], startPoint: .top, endPoint: .bottom)
      )
      
    }//body
  }
}

#Preview {
  RecipeListView(category: createStubRecipes()[0].category)
    .environment(\.modelContext, createPreviewModelContainer().mainContext)
}
