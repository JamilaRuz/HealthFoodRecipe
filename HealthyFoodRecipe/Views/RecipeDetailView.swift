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
  
  @State private var isSelecting = false
  @State var selectedDay = Day.Monday
  @Bindable var recipe: Recipe
  
  let picsApiUrl = "http://127.0.0.1:8002/pictures/"
  
  
  var body: some View {
    ScrollView() {
      TabView {
        ForEach(recipe.images, id: \.self) { imageUrl in
          AsyncImage(url: URL(string: picsApiUrl + imageUrl)) { phase in
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
      } //Scroll Horizontal
      .tabViewStyle(PageTabViewStyle())
      .frame(height: 300)
      .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
      
      Text(recipe.name)
        .font(.title)
        .bold()
        .foregroundColor(.pink2)
        .multilineTextAlignment(.center)
        .padding(5)
      
      VStack(spacing: 15) {
        
        VStack(alignment: .leading, spacing: 5) {
          HStack {
            Text("Ингредиенты:")
              .font(.headline)
              .foregroundColor(.pink2)
            Spacer()
            Button(action: {
              //                            isFavorited.toggle()
              recipe.isFavorite.toggle()
            }) {
              Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                .resizable()
                .tint(Color.pink2)
                .frame(width: 30, height: 30)
            }
          }
          
          let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
          ]
          
          LazyVGrid(columns: columns, spacing: 5) {
            ForEach(recipe.ingredients, id: \.self) { ingredient in
              HStack(spacing: 5) { // Adjust spacing as needed
                Image(systemName: "circle.fill")
                  .font(.system(size: 5)) // Adjust the size as needed
                Text("\(ingredient.name)")
                  .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                  .multilineTextAlignment(.leading)
              }
              Text("\(String(format: "%g", ingredient.quantity)) (\(ingredient.unit))")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
          }
          .padding(.bottom, 10)
          
          Divider()
          
          VStack(alignment: .leading, spacing: 10) {
            HStack {
              Text("Способ приготовления:")
                .font(.headline)
                .foregroundColor(.green)
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
            //                            .background(LinearGradient(colors: [.green3, .green1], startPoint: .top, endPoint: .bottom))
              .background(LinearGradient(colors: [.pink3, .pink2], startPoint: .top, endPoint: .bottom))
              .foregroundColor(.white)
              .font(.body)
              .bold()
              .cornerRadius(10)
              .padding(15)
          }
        }
      }
      .padding(.horizontal, 15)// why is it so big
    }
    .ignoresSafeArea(.container, edges: .top)
    .background(
      //                Image("bg_pink")
      //                    .resizable()
      //                    .scaledToFill()
      //                    .overlay(Color.black.opacity(0.2))
      //                    .ignoresSafeArea()
      Color(.pink1)
        .opacity(0.5)
    )
  }
  
  
}

#Preview {
  RecipeDetailView(recipe: createStubRecipes()[0])
    .environment(\.modelContext, createPreviewModelContainer().mainContext)
}
