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
                CarouselView()
                Text("Choose a category")
                    .font(.title2)
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach([String](Set(recipes.map{$0.category})), id: \.self) { category in
                            NavigationLink(destination: RecipeListView(category: category)) {
                                CardView(category: category)
                            }
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Our dishes")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background {
//                Color.lightPurple.opacity(0.5)
//                    .ignoresSafeArea()
//            }
        }
        
    }
}

#Preview {
    CategoryListView()
        .modelContainer(for: Recipe.self, inMemory: true)
//        .modelContainer(for: Recipe.self, inMemory: true)
}
