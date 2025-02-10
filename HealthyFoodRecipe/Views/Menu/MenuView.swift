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
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    ForEach(Day.allCases, id: \.self) { day in
                        MenuDayView(day: day)
                            .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .pinkGradientBackground(colorScheme: colorScheme)
            .navigationTitle("Меню на неделю")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .accentColor(colorScheme == .dark ? .white : Color("green1"))
    }
}

#Preview {
    MenuView()
        .environment(\.modelContext, createPreviewModelContainer().mainContext)
}
