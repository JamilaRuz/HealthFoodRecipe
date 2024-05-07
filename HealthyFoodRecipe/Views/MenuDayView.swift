//
//  MenuDayView.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 4/30/24.
//

import SwiftUI
import SwiftData

struct CustomGroupBoxStyle: GroupBoxStyle {
  func makeBody(configuration: Configuration) -> some View {
    
    VStack(alignment: .leading) {
      configuration.label
        .foregroundColor(Color.pink3)
        .bold()
      configuration.content
    }
    .frame(height: 200)
    .background(Color.white.opacity(0.8))
    .border(Color.black)
  }
}

extension GroupBoxStyle where Self == CustomGroupBoxStyle {
  static var custom: CustomGroupBoxStyle { .init() }
}

struct MenuDayView: View {
  @Environment(\.modelContext) private var modelContext
  @Query private var menuItems: [MenuItem]
  
  let day: Day
  
  init(day: Day) {
    self.day = day
    
    let dayRawValue: String? = day.rawValue
    
    self._menuItems = Query(filter: #Predicate<MenuItem> {
      $0.day == dayRawValue
    })
  }

  
  // GroupBox
  var body: some View {
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
          
          let categoriesForToday = Array(Set(menuItems.map { $0.recipe?.category.name }))
          ForEach(categoriesForToday, id: \.self) { category in
            Text("\(category ?? "None"):")
              .italic()
            
            //Recipes
            ForEach(menuItems.filter { $0.recipe?.category.name == category }, id: \.self) { menuItem in
              HStack {
                HStack {
                  Image(systemName: "circle.fill")
                    .foregroundColor(.gray)
                    .font(.system(size: 8))
                  Text(menuItem.recipe?.name ?? "None")
                }
                
                Spacer()
                
                Button(action: {
                  menuItem.isChecked.toggle()
                }) {
                  Image(systemName: menuItem.isChecked ? "checkmark" : "circle")
                    .foregroundColor(menuItem.isChecked ? .pink3 : .gray)
                }
              }
              Divider()
                .foregroundColor(.pink3)
              
            } //ForEach recipes
          } //ForEach categories
        }
      }
    label: {
      Text(day.displayName)
        .font(.title2)
      }
    .padding(.horizontal, 10)
//    .groupBoxStyle(.custom)
    .shadow(radius: 5)
    }

  } //body
} //struct
  
#if DEBUG
  struct MenuDayView_Previews: PreviewProvider {
    static var previews: some View {
      MenuDayView(day: .Monday)
    }
  }
#endif
