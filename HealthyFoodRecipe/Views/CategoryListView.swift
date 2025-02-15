//
//  CategoryListView.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 3/21/24.
//

import SwiftUI
import SwiftData

struct CategoryListView: View {
  @Environment(\.modelContext) var modelContext
  @Environment(\.colorScheme) var colorScheme
  @Query private var recipes: [Recipe]
  @Query private var menuItems: [MenuItem]
  @State private var searchTerm = ""
  
  let categories = getAllCategories()
  
  let columns = [
    GridItem(.flexible(), spacing: 15),
    GridItem(.flexible(), spacing: 15)
  ]
  
  var filteredRecipes: [Recipe] {
    guard !searchTerm.isEmpty else { return [] }
    return recipes.filter { $0.name.localizedCaseInsensitiveContains(searchTerm) }
  }
  
  var body: some View {
    NavigationStack {
      ZStack {
        if searchTerm.isEmpty {
          // Regular view with white background
          ScrollView {
            VStack(spacing: 0) {
              Text("Dileknutrition")
                .font(.custom("Snell Roundhand Bold", size: 32))
                .fontWeight(.black)
                .tracking(5)
                .padding(.bottom, 15)
              
              HStack {
                Image("banner")
                  .resizable()
                  .scaledToFill()
                  .cornerRadius(10)
              }
              .padding(.horizontal)
              .frame(maxHeight: 150)
              .shadow(radius: 10)
              
              LazyVGrid(columns: columns, spacing: 10) {
                ForEach(categories, id: \.self) { category in
                  NavigationLink(destination: RecipeListView(category: category)) {
                    CardView(category: category)
                  }
                }
              }
              .padding(.top, 24)
              .padding(.horizontal)
            }
          }
          .background(colorScheme == .dark ? Color.black : .white)
        } else {
          // Search results with gradient background
          VStack {
            List {
              ForEach(filteredRecipes, id: \.self) { recipe in
                NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                  VStack(alignment: .leading, spacing: 4) {
                    Text(recipe.category.name)
                      .font(.caption)
                      .foregroundColor(Color("green1"))
                    RecipeListRowView(recipe: recipe, menuItems: menuItems)
                  }
                }
                .listRowBackground(colorScheme == .dark ? Color(.systemGray6) : Color(.systemBackground))
              }
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .background(Color.clear)
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .pinkGradientBackground(colorScheme: colorScheme)
        }
      }
      .searchable(
        text: $searchTerm,
        prompt: Text("Поиск рецептов")
      )
      .tint(colorScheme == .dark ? .gray : Color("green1"))
      .foregroundColor(colorScheme == .dark ? .gray : .black)
    }
  }
}

struct PlaceholderStyle: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: String

    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                Text(placeholder)
                    .foregroundColor(.gray)
            }
            content
        }
    }
}

#Preview {
  CategoryListView()
    .environment(\.modelContext, createPreviewModelContainer().mainContext)
}
