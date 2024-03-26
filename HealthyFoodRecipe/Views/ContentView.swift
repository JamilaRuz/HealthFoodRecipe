//
//  ContentView.swift
//  HealthFoodRecipe
//
//  Created by Jamila Ruzimetova on 3/19/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var menuItems: [MenuItem]

    var body: some View {
        NavigationView {
            List {
                ForEach(Day.allCases, id: \.self) { weekday in
                    Section("\(weekday)") {
                        ForEach(menuItems) { recipeSelected in
                            if recipeSelected.day == weekday.rawValue {
                                HStack {
                                    Text("\(getCategory(for: recipeSelected.recipeName ?? ""))")
                                        .bold()
                                        .foregroundStyle(.secondary)
                                    Text(recipeSelected.recipeName ?? "")
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Menu for the week")
            }
        }
    }
    
    func getCategory(for recipe: String) -> String {
        let thisRecipe = recipes.first(where: {$0.name == recipe})
        
        return thisRecipe?.category ?? "None"
    }
}

#Preview {
    ContentView()
        .modelContainer(for: MenuItem.self, inMemory: true)
}
