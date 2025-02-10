//
//  View+Extensions.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 4/25/24.
//

import SwiftUI
import SwiftData

extension View {
    func pinkGradientBackground(colorScheme: ColorScheme) -> some View {
        self.background(
            GeometryReader { _ in
                if colorScheme == .dark {
                    Color(.black)
                        .ignoresSafeArea()
                } else {
                    LinearGradient(
                        colors: [Color("pink2"), Color("pink1"), .white],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea()
                }
            }
        )
    }
    
    func lightPinkGradientBackground() -> some View {
        self.background(
            LinearGradient(
                colors: [Color("pink1").opacity(0.5), .white],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
    }
    
}
