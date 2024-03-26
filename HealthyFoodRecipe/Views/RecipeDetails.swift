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
                Text(thisRecipe.name)
                    .font(.title)
                Spacer()
            }
                
//            Text(thisRecipe.ingredients)
//                .multilineTextAlignment(.leading)
            Text(thisRecipe.directions)
            Spacer()
            
            Picker("Select a day to add to the menu", selection: $selectedDay) {
                ForEach(Day.allCases, id: \.self) {
                    Text($0.rawValue).tag($0)
                }
            }
            
            Button(action: {
                let thisMenuItem = MenuItem(recipeName: thisRecipe.name, day: selectedDay.rawValue)
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

#Preview {
    RecipeDetails(thisRecipe: Recipe(name: "", image: "", ingredients: [""], directions: "", category: "Salads", datePublished: ""))
}
