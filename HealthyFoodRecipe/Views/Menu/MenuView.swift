//
//  MenuView.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 4/2/24.
//

import SwiftUI
import SwiftData

struct MenuView: View {
  
  var body: some View {
    NavigationView {
      VStack {
        ScrollView(.vertical) {
          ForEach(Day.allCases, id: \.self) { day in
            MenuDayView(day: day)
          }
        }
      }//Vstack main
      .navigationTitle("Меню на неделю")
      .navigationBarTitleDisplayMode(.inline)
      .background(
        LinearGradient(colors: [.pink2, .pink1, .white], startPoint: .top, endPoint: .bottom)
      )
    }
  }//body
}

#Preview {
  MenuView()
    .environment(\.modelContext, createPreviewModelContainer().mainContext)
}
