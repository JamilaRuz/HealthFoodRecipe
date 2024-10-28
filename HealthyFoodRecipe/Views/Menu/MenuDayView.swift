//
//  MenuDayView.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 4/30/24.
//

import SwiftUI
import SwiftData

struct MenuDayView: View {
  @Environment(\.modelContext) private var modelContext
  @Query private var menuItems: [MenuItem]
  
  @State private var isBeingDeleted = false
  let day: Day
  
  init(day: Day) {
    self.day = day
    
      let dayRawValue: String = day.rawValue
    
    self._menuItems = Query(filter: #Predicate<MenuItem> {
      $0.day == dayRawValue
    })
  }
  
  var body: some View {
    //   GroupBox
    VStack {
      GroupBox {
        if menuItems.isEmpty {
          Text("Нет блюд на сегодняшний день")
            .font(.callout)
            .foregroundColor(.gray)
        } else {
          //Categories
          Divider()
            .foregroundColor(.pink3)
          
          let categoriesForToday = Array(Set(menuItems.map { $0.recipe?.category.name ?? "Unknown" }
                .filter { $0 != "Unknown" } )).sorted()
          ForEach(categoriesForToday, id: \.self) { category in
            HStack {
              Text("\(category):")
                .italic()
                .foregroundColor(.pink3)
              Spacer()
            }
            
            //Recipes
            ForEach(menuItems.filter { $0.recipe?.category.name == category }, id: \.self) { menuItem in
              HStack {
                HStack {
                  Image(systemName: "circle.fill")
                    .foregroundColor(.gray)
                    .font(.system(size: 8))
                  Text(menuItem.recipe?.name ?? "Unknown")
                    .lineLimit(1)
                    .truncationMode(.tail)
                }
                .opacity(menuItem.isChecked ? 0.3 : 1)
                
                Spacer()
                
                Button(action: {
                  menuItem.isChecked.toggle()
                  if menuItem.isChecked {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                      withAnimation(.easeInOut(duration: 0.5).delay(0.2)) {
                        do {
                          modelContext.delete(menuItem)
                          try modelContext.save()
                        } catch {
                          print("Failed to save context: \(error)")
                          // TODO Handle the error appropriately
                        }
                      }
                    }
                  }
                }) {
                  Image(systemName: menuItem.isChecked ? "checkmark" : "circle")
                    .foregroundColor(menuItem.isChecked ? .pink3 : .green1)
                }
              }
              Divider()
            } //ForEach recipes
          } //ForEach categories
        }
      }
    label: {
      Text(day.displayName)
        .font(.title2)
        .fontDesign(.monospaced)
        .foregroundColor(.green1)
    }
    .padding(.horizontal, 10)
//    .groupBoxStyle(.custom)
    .shadow(radius: 5)
    }
    
  } //body
} //struct

#Preview {
  MenuDayView(day: .Monday)
    .environment(\.modelContext, createPreviewModelContainer().mainContext)
}
