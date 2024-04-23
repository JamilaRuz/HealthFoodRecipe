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
        ScrollView() {
            ScrollView(.horizontal, showsIndicators: true) {
                ForEach(recipe.images, id: \.self) { imageUrl in
                    AsyncImage(url: URL(string: imageUrl)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 100, height: 80)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(5)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width, height: 300)
                                .clipped()
                        case .failure:
                            Image("placeholderImg")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width, height: 300)
                                .clipped()
                        @unknown default:
                            Image("placeholderImg")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width, height: 300)
                                .clipped()
                        }
                    }
                } //ForEach
            } //Vstack
            .frame(height: 300)
            .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
            
            VStack(spacing: 15) {
                Text(recipe.name)
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text("Ингредиенты")
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
                        Text(recipe.instructions)
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
        Recipe(
            id: 1,
            name: "Клубничный пуддинг с чиа",
            images: ["dish1"],
            ingredients:
                [Ingredient(name: "Свежая клубника", unit: "гр", quantity: 200),
                 Ingredient(name: "Семена Чиа", unit: "ч.л", quantity: 3),
                 Ingredient(name: "Кефир 3.2%", unit: "л", quantity: 1),
                 Ingredient(name: "Сахзам", unit: "ts", quantity: 0.25)],
            instructions:
            "In a medium saucepan combine 3 cups of the strawberries and the orange juice. Mash until berries are coarsely chopped. Cook over medium until mixture has a jam-like consistency, about 20 minutes. Cool 15 minutes. In a medium bowl whisk together milk, chia seeds, maple syrup, and vanilla. Stir in cooked strawberries. Cover and chill at least 3 hours or overnight. Spoon pudding and the remaining 3 cups fresh strawberries into serving dishes or glasses.",
            category: Category(name: "Напитки", image: "drink"),
            isFavorite: false,
            menuItems: []
    )
     )
        .modelContainer(for: MenuItem.self, inMemory: true)
}
