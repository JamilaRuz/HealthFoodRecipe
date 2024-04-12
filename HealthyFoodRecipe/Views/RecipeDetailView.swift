//
//  RecipeDetails.swift
//  HealthFoodRecipe
//
//  Created by Jamila Ruzimetova on 3/20/24.
//

import SwiftUI
import SwiftData



struct RecipeDetailView: View {
    @Query private var menuItems: [MenuItem]
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

//    @State private var isFavorited = false
    @State private var isSelecting = false
    @State var selectedDay = Day.Monday
    @Bindable var recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack {
                Image(recipe.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: 300)
                    .clipped()
            } //image
            .frame(height: 300)
            .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
            
            VStack(spacing: 15) {
                Text(recipe.name)
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text("Ingredients")
                            .font(.headline)
                        Spacer()
                        Button(action: {
//                            isFavorited.toggle()
                            recipe.isFavorite.toggle()
                        }) {
                            Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                                .resizable()
                                .tint(Color.lightPurple)
                                .frame(width: 30, height: 30)
                        }
                    }
                        
                    let columns = [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ]
                    
                    LazyVGrid(columns: columns, spacing: 5) {
                        ForEach(recipe.ingredients, id: \.name) { ingredient in
                            Text("\(String(format: "%g", ingredient.quantity)) (\(ingredient.unit)) -")
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            Text("\(ingredient.name)")
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .multilineTextAlignment(.leading)
                        }
                    }

                    Divider()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Инструкции")
                            .font(.headline)
                        Text(recipe.directions)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 0) {
                    Text("Выберите день для добавления в меню")
                        .foregroundColor(.gray)
                        .font(.caption2)
                    
                    Picker("Выберите день недели", selection: $selectedDay) {
                        ForEach(Day.allCases, id: \.self) {
                            Text($0.displayName).tag($0)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    Button(action: {
                        let thisMenuItem = MenuItem(day: selectedDay.rawValue, isChecked: false, recipe: recipe)
                        modelContext.insert(thisMenuItem)
                        
                        dismiss()
                    }) {
                        Text("Добавить")
                            .frame(width: 150, height: 50)
                            .background(LinearGradient(colors: [.purple, .lightPurple], startPoint: .top, endPoint: .bottom))
                            .foregroundColor(.white)
                            .font(.body)
                            .bold()
                            .cornerRadius(10)
                            .padding(15)
                    }
                }
            }
            .padding(.horizontal, 10)// why is it so big
        }
        .ignoresSafeArea(.container, edges: .top)
    }
    
    
}

#Preview {
    RecipeDetailView(recipe: 
//        Recipe(
//            name: "Клубничный пуддинг с чиа",
//            image: "dish1",
//            ingredients:
//                [Ingredient(name: "Свежая клубника", unit: "гр", quantity: 200),
//                 Ingredient(name: "Семена Чиа", unit: "ч.л", quantity: 3),
//                 Ingredient(name: "Кефир 3.2%", unit: "л", quantity: 1),
//                 Ingredient(name: "Сахзам", unit: "ts", quantity: 0.25)],
//            directions:
//            "In a medium saucepan combine 3 cups of the strawberries and the orange juice. Mash until berries are coarsely chopped. Cook over medium until mixture has a jam-like consistency, about 20 minutes. Cool 15 minutes. In a medium bowl whisk together milk, chia seeds, maple syrup, and vanilla. Stir in cooked strawberries. Cover and chill at least 3 hours or overnight. Spoon pudding and the remaining 3 cups fresh strawberries into serving dishes or glasses.",
//            category: Category(name: "Напитки", image: "drink"),
//            isFavorite: false,
//            menuItems: []
//    )
         Recipe(
             name: "ПП Мохито",
             image: "drink1",
             ingredients:
                 [Ingredient(name: "Минеральная вода", unit: "л", quantity: 1),
                  Ingredient(name: "лайм", unit: "шт", quantity: 2),
                  Ingredient(name: "сахзам", unit: "ст.л", quantity: 3),
                  Ingredient(name: "листья мяты", unit: "шт", quantity: 10)],
             directions: "Нарезать лайм кружочками. В минеланую воду добавить лайм, сахзам по вкусу, мяты и выдавить сок 2 лаймов. Все перемешать и потреблять добавив лед.",
             category: Category(name: "Напитки", image: "drink"),
             isFavorite: true,
             menuItems: []
         )
     )
        .modelContainer(for: MenuItem.self, inMemory: true)
 
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true) // Store the container in memory since we don't actually want to save the preview data
//        let container = try ModelContainer(for: Recipe.self, configurations: config)
//        
//        return RecipeDetails(recipe: recipes[0])
//            .modelContainer(container)
//    } catch {
//        return Text("Failed to create preview: \(error.localizedDescription)")
//    }
}
