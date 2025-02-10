//
//  RecipeDetailView.swift
//  HealthFoodRecipe
//
//  Created by Jamila Ruzimetova on 3/20/24.
//

import SwiftUI
import SwiftData
import StoreKit

struct RecipeDetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    @State private var isSelecting = false
    @State var selectedDay = Day.Monday
    @Bindable var recipe: Recipe
    @StateObject private var ratingManager = RatingManager()
    
    let picsApiUrl = ApiConf.baseUrl + "pictures/"
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                TabView {
                    if recipe.images.isEmpty {
                        ZStack {
                            Rectangle()
                                .fill(
                                    LinearGradient(
                                        colors: [Color("pink2"), Color("pink1"), .white],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                            Text("Нет фото")
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                        }
                        .modifier(RecipeImageModifier())
                    } else {
                        ForEach(recipe.images, id: \.self) { imageUrl in
                            AsyncImage(url: URL(string: picsApiUrl + imageUrl)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .modifier(RecipeImageModifier())
                                case .failure:
                                    ZStack {
                                        Rectangle()
                                            .fill(
                                                LinearGradient(
                                                    colors: [Color("pink2"), Color("pink1"), .white],
                                                    startPoint: .top,
                                                    endPoint: .bottom
                                                )
                                            )
                                        Text("Нет фото")
                                            .font(.title3)
                                            .fontWeight(.medium)
                                            .foregroundColor(.white)
                                    }
                                    .modifier(RecipeImageModifier())
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(height: 200)
                .padding(.top, 16)
                
                VStack(spacing: 15) {
                    Text(recipe.name)
                        .font(.title)
                        .bold()
                        .foregroundColor(.pink2)
                        .multilineTextAlignment(.center)
                        .padding(5)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text("Ингредиенты:")
                                .font(.headline)
                                .foregroundColor(.pink2)
                            Spacer()
                            Button(action: {
                                recipe.isFavorite.toggle()
                            }) {
                                Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                                    .resizable()
                                    .tint(Color.pink2)
                                    .frame(width: 30, height: 30)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(recipe.ingredients)
                                .font(.body)
                        }
                        
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("Способ приготовления:")
                                    .font(.headline)
                                    .foregroundColor(.green1)
                                Spacer()
                                
                                Image("cooking")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                            }
                            
                            Text(recipe.instructions)
                        }
                        .padding(.top, 10)
                    }
                    
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
                                .background(LinearGradient(colors: [.pink3, .pink2], startPoint: .top, endPoint: .bottom))
                                .foregroundColor(.white)
                                .font(.body)
                                .bold()
                                .cornerRadius(10)
                                .padding(15)
                        }
                    }
                }
                .padding(.horizontal, 15)
            }
        }
        .background(colorScheme == .dark ? Color.black : Color("pink1").opacity(0.5))
        .onAppear {
            checkAndShowRating()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationBarBackButtonHidden(false)
    }
    
    private func checkAndShowRating() {
        if ratingManager.shouldRequestReview() {
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
    }
    
    
}

struct RecipeImageModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .frame(height: 180)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(colorScheme == .dark ? Color(.systemGray6) : .white)
                    .shadow(color: .gray.opacity(0.2), radius: 8, x: 0, y: 4)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color("pink2"), lineWidth: 3)
                    .padding(1)
            )
            .padding(.horizontal, 16)
    }
}

#Preview {
    RecipeDetailView(recipe: createStubRecipes()[1])
        .modelContainer(for: [Recipe.self, MenuItem.self], inMemory: true)
}
