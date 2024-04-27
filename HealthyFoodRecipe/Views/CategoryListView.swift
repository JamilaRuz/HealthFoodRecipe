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

struct CategoryListView_Previews: PreviewProvider {

    static var previews: some View {
        let categories = [
            Category(name: "Завтраки", image: "breakfast"),
            Category(name: "Основные блюда", image: "dish"),
            Category(name: "Супы", image: "soup"),
            Category(name: "Салаты", image: "salad"),
            Category(name: "Выпечки", image: "baking"),
            Category(name: "Аппетайзеры", image: "appetizer"),
            Category(name: "Напитки", image: "drink"),
            Category(name: "Десерты", image: "dessert")
        ]
        
        CategoryListView()
        
        ForEach(1...6, id: \.self) { number in
            CardView(category: categories[number - 1])
                .modelContainer(for: Recipe.self, inMemory: true)
        }
    }
}
