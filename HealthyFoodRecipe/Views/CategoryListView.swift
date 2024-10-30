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
  
  let categories = getAllCategories()
  
  let columns = [
    GridItem(.adaptive(minimum: 150))
  ]
  
  var body: some View {
    NavigationStack {
      VStack(alignment: .leading) {
          VStack(alignment: .center) {
              Text("Dileknutrition")
                  .font(.custom("Snell Roundhand Bold", size: 32))
                  .fontWeight(.black)
                  .tracking(5)
                  .frame(maxWidth: .infinity, alignment: .center)
          }
        HStack {
          Image("banner")
            .resizable()
            .scaledToFill()
            .overlay(
                VStack {
                    Spacer()
                    Text("dileknutrition.com")
                        .foregroundStyle(.black)
                        .font(.system(size: 16, weight: .semibold))
                        .shadow(color: .white, radius: 1, x: 0, y: 0)
                        .padding(.vertical, 4)
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.7))
                        .padding(.bottom, 10)
                }
            )
        }
        .frame(maxWidth: .infinity, maxHeight: 150)
        .cornerRadius(10)
        .shadow(radius: 10)
        
        Text("Категории")
          .font(.title2)
        ScrollView {
          LazyVGrid(columns: columns, spacing: 20) {
            ForEach(categories, id: \.self) { category in
              NavigationLink(destination: RecipeListView(category: category)) {
                CardView(category: category)
              }
            }
          }
        }
        .refreshable {
          print("Refresh...")
          await DataImporter(modelContext: modelContext).importData(resetLastChangeTime: false)
        }
      }
      .padding()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }//NavigationStack
    
  }
}

#Preview {
  CategoryListView()
    .environment(\.modelContext, createPreviewModelContainer().mainContext)
}
