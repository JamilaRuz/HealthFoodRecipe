//
//  AsyncImageView.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 4/25/24.
//

import SwiftUI

struct RecipeListRowView: View {
  
  let picsApiUrl = ApiConf.baseUrl + "pictures/"
  let recipe: Recipe
  let menuItems: [MenuItem]  // Add this
  
  var isInMenu: Bool {
    menuItems.contains { $0.recipe?.id == recipe.id }
  }
  
  var body: some View {
    HStack {
      AsyncImage(url: URL(string: picsApiUrl + (recipe.images.first ?? ""))) { phase in
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
           .font(.system(size: 16, weight: .semibold, design: .rounded))

        
        HStack {
          if recipe.isFavorite {
            Image(systemName: "heart.fill")
              .foregroundColor(.pink2)
          }
          if isInMenu {  // Changed this condition
            Image(systemName: "menucard.fill")
              .foregroundColor(.green1)
          }
        }
      }
      .padding(.horizontal, 5)
      
      Spacer()
    }
  }
}

#Preview {
  RecipeListView(category: Category(name: "Breakfasts", image: "breakfast1"))
}

