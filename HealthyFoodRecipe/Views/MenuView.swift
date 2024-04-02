//
//  MenuView.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 4/2/24.
//

import SwiftUI
import SwiftData

struct MenuView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var menuItems: [MenuItem]
    @State private var isSubscribed = false
    
    //    @Query var recipes: [Recipe]
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(Day.allCases, id: \.self) { weekday in
                        Section(
                            header: Text("\(weekday)")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                        ) {
                            ForEach(menuItems) { recipeSelected in
                                if recipeSelected.day == weekday.rawValue {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 5) {
                                            Text(recipeSelected.recipeName ?? "")
                                                .lineLimit(1)
                                                .font(.callout)
                                                .bold()
                                                .opacity(isSubscribed ? 0.3 : 1.0)
                                            Text("(\(getCategory(for: recipeSelected.recipeName ?? "")))")
                                                .foregroundStyle(.secondary)
                                                .font(.caption)
                                        }
                                        
                                        Spacer()
                                        
                                        Image(systemName: isSubscribed ? "checkmark.circle.fill" : "circle")
                                            .foregroundColor(.pink)
                                            .padding()
                                            .onTapGesture {
                                                withAnimation(.easeInOut(duration: 1.0)) {
                                                    isSubscribed.toggle()
                                                }
                                            }
                                    }
                                    .contentShape(Rectangle())
                                }
                            }
                            .listRowSeparatorTint(.pink)
                        }//section
                    }
//                    .listRowBackground(
//                        Capsule()
//                            .fill(Color(white: 1, opacity: 0.8))
//                            .padding(.vertical, 2)
//                    )
                } //list
                
            } //Vstack main
            .navigationTitle("Menu for the week")
            .navigationBarTitleDisplayMode(.inline)
            .scrollContentBackground(.hidden)
            .background(
//                Image("fruits-bg")
//                    .resizable()
//                    .scaledToFill()
//                    .blur(radius: 3)
//                    .overlay(Color.indigo.opacity(0.1))
//                    .ignoresSafeArea(.container)
                LinearGradient(colors: [.lightPurple, .pink, .white], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
        }
        
    }//body

    func getCategory(for recipe: String) -> String {
        let thisRecipe = recipes.first(where: {$0.name == recipe})
        
        return thisRecipe?.category ?? "None"
    }
}

#Preview {
    MenuView()
        .modelContainer(for: MenuItem.self, inMemory: true)
}
