//
//  RecipeDetails.swift
//  HealthFoodRecipe
//
//  Created by Jamila Ruzimetova on 3/20/24.
//

import SwiftUI
import SwiftData

struct RecipeDetails: View {
    @Environment(\.modelContext) var modelContext
    @Query private var items: [MenuItem]
    
    let thisRecipe: Recipe
    
    @State var selectedDay = Day.Monday
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(thisRecipe.Title ?? "N/A")
                    .font(.title)
                Spacer()
            }
                
            Text(thisRecipe.Ingredient01 ?? "N/A")
            Text(thisRecipe.Ingredient02 ?? "N/A")
            Text(thisRecipe.Ingredient03 ?? "N/A")
            Text(thisRecipe.Ingredient04 ?? "N/A")
            Text(thisRecipe.Unit01 ?? "N/A")
                .padding(.top)
            Text(thisRecipe.Directions ?? "N/A")
            Spacer()
            
            Picker("Select a day to add to the menu", selection: $selectedDay) {
                ForEach(Day.allCases, id: \.self) {
                    Text($0.rawValue).tag($0)
                }
            }
            
            Button(action: {
                let thisMenuItem = MenuItem(recipeName: thisRecipe.Title ?? "N/A", day: selectedDay.rawValue)
                modelContext.insert(thisMenuItem)
                
                dismiss()
            }) {
                Text("Add to weekly menu")
                    .padding()
            }
        }
        .padding()
    }
}

//#Preview {
//    RecipeDetails()
//}
