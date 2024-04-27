//
//  AsyncImageView.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 4/25/24.
//

import SwiftUI

struct ListRowView: View {
    
let recipe: Recipe
    
    var body: some View {
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
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(2)
                
                HStack {
                    if recipe.isFavorite {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.accentColor)
                    }
                    if !(recipe.menuItems?.isEmpty ?? true) {
                        Image(systemName: "menucard.fill")
                            .foregroundColor(.green2)
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
    
