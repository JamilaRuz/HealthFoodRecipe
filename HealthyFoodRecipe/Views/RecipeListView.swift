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
  
  @Binding private var isAppActivated: Bool
  
  @Environment(\.modelContext) var modelContext
  @Query private var recipes: [Recipe]
  @State private var searchTerm = ""
  @State private var isActivationShown = false
  
  var filteredRecipes: [Recipe] {
    let categoryFiltered = recipes.filter {$0.category == category}
    guard !searchTerm.isEmpty else { return categoryFiltered }
    
    return categoryFiltered.filter { $0.name.localizedCaseInsensitiveContains(searchTerm)}
  }
  
  init(category: Category, isAppActivated: Binding<Bool>) {
    self.category = category
    self._isAppActivated = isAppActivated
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
        
        if !self.isAppActivated {
          Button(action: {
            isActivationShown.toggle()
          }) {
            Text("Активировать приложение")
              .font(.headline)
              .foregroundColor(.white)
              .padding()
              .frame(maxWidth: .infinity)
              .background(
                LinearGradient(colors: [.pink3, .pink2], startPoint: .top, endPoint: .bottom)
              )
              .cornerRadius(10)
              .shadow(radius: 5)
              .padding(.horizontal)
              .padding(.bottom, 10)
          }
        }
      }//nav stack
      .background(
        LinearGradient(colors: [.pink2, .pink1, .white], startPoint: .top, endPoint: .bottom)
      )
      
    }//body
    .sheet(isPresented: $isActivationShown) {
      ActivationView(isAppActivated: self.$isAppActivated)
    }
  }
}

#Preview {
  RecipeListView(category: createStubRecipes()[0].category, isAppActivated: .constant(false))
    .environment(\.modelContext, createPreviewModelContainer().mainContext)
}
