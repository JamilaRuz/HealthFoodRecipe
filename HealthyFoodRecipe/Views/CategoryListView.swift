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
  @Query private var recipes: [Recipe]
  
  let columns = [
    GridItem(.adaptive(minimum: 150))
  ]
  
  var body: some View {
    NavigationStack {
      VStack(alignment: .leading) {
        
        HStack {
          Image("banner")
            .resizable()
            .scaledToFill()
        }
        .frame(maxWidth: .infinity, maxHeight: 150)
        .cornerRadius(10)
        .shadow(radius: 10)
        
        Text("Категории")
          .font(.title2)
        ScrollView {
          LazyVGrid(columns: columns, spacing: 20) {
            let categories = [Category](Set(recipes.map{$0.category}))
              .sorted(by: { $0.name < $1.name })
            ForEach(categories, id: \.self) { category in
              NavigationLink(destination: RecipeListView(category: category)) {
                CardView(category: category)
              }
            }
          }
        }
        .refreshable {
          print("Refresh...")
          await DataImporter(modelContext: modelContext).importData()
        }
      }
      .padding()
      .navigationTitle("Похудейка")
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      //            .background {
      //                Color.purple1.opacity(0.5)
      //                    .ignoresSafeArea()
      //            }
    }
    
  }
}

#Preview {
  CategoryListView()
    .environment(\.modelContext, createPreviewModelContainer().mainContext)
}
