//
//  MenuView.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 4/2/24.
//

import SwiftUI
import SwiftData

struct MenuView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.vertical) {
                    ForEach(Day.allCases, id: \.self) { day in
                        MenuDayView(day: day)
                    }
                }
            }
            .navigationTitle("Меню на неделю")
            .navigationBarTitleDisplayMode(.inline)
            .background(
                Group {
                    if colorScheme == .dark {
                        LinearGradient(colors: [Color(red: 0.2, green: 0.1, blue: 0.2), Color.black], startPoint: .top, endPoint: .bottom)
                    } else {
                        LinearGradient(colors: [Color("pink2"), Color("pink1"), .white], startPoint: .top, endPoint: .bottom)
                    }
                }
            )
        }
        .accentColor(colorScheme == .dark ? .white : Color("green1"))
    }
}

#Preview {
    MenuView()
        .environment(\.modelContext, createPreviewModelContainer().mainContext)
}
