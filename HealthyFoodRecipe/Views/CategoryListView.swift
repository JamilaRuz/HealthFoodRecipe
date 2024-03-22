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
    @Query private var menuItems: [MenuItem]
    
    let images = ["dessert", "dish", "garnish", "meat", "soup"]
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack(spacing: 0) {
                        ForEach(images, id: \.self) { image in
                            Image(image)
                                .scaledToFill()
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 150)
                .cornerRadius(10)
                .shadow(radius: 10)
                
                Text("Choose a category")
                    .font(.title2)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach([String](Set(recipes.map{$0.Category!})), id: \.self) { category in
                            NavigationLink(destination: RecipeListView(category: category)) {
                                CardView(category: category)
                            }
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Our dishes")
//            background color
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Color.gray.opacity(0.1)
                    .ignoresSafeArea()
            }
        }
        
    }
}

#Preview {
    CategoryListView()
        .modelContainer(for: MenuItem.self, inMemory: true)
}
