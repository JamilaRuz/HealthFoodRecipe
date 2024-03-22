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
    
    var body: some View {
        NavigationStack {
            VStack() {
                ForEach([String](Set(recipes.map{$0.Category!})), id: \.self) { category in
                    NavigationLink(destination: RecipeListView(category: category)) {
                        Text(category)
                    }
                }
            }
            .frame(width: 150, height: 100)
            .cornerRadius(3.0)
            .navigationTitle("Categories")
        }
    }
}

#Preview {
    CategoryListView()
        .modelContainer(for: MenuItem.self, inMemory: true)
}
