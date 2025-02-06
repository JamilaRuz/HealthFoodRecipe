//
//  AboutUsView.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 10/25/24.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    @State private var opacity = 0.0
    @State private var firstPartOffset = UIScreen.main.bounds.width
    @State private var secondPartOffset = UIScreen.main.bounds.width
    @State private var authorOpacity = 0.0
    @State private var logoScale = 0.5
    
    var isPreview: Bool = false
    
    private let firstPartText = "ПП Рецепты от участниц"
    private let secondPartText = "программы \"Похудейка\""
    private let authorText = "с Дилек Умаровой"
    
    var body: some View {
        if isActive && !isPreview {
            ContentView()
        } else {
            VStack(spacing: 20) {
                Image("logo2")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .scaleEffect(logoScale)
                
                VStack(spacing: 2) {
                    Text(firstPartText)
                        .font(.custom("Oswald", size: 32, relativeTo: .title))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .offset(x: firstPartOffset)
                    
                    Text(secondPartText)
                        .font(.custom("Oswald", size: 32, relativeTo: .title))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .offset(x: secondPartOffset)
                }
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                
                Text(authorText)
                    .font(.custom("Oswald", size: 36, relativeTo: .title))
                    .fontWeight(.bold)
                    .foregroundColor(.pink2)
                    .opacity(authorOpacity)
            }
            .opacity(opacity)
            .onAppear {
                // Add logo growth animation
                withAnimation(.easeOut(duration: 0.8)) {
                    self.logoScale = 1.0
                    self.opacity = 1.0
                }
                
                // Animate first part of text from right to left
                withAnimation(.easeOut(duration: 0.8).delay(0.4)) {
                    self.firstPartOffset = 0
                }
                
                // Animate second part of text from right to left
                withAnimation(.easeOut(duration: 0.8).delay(0.8)) {
                    self.secondPartOffset = 0
                }
                
                // Fade in author text
                withAnimation(.easeIn(duration: 1.0).delay(1.2)) {
                    self.authorOpacity = 1.0
                }
                
                // Navigate to main content
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                ZStack {
                    Image("bg_pink")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                    
                    // Add white transparent overlay
                    Color.white.opacity(0.3)
                }
            )
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    SplashScreen(isPreview: true)
}
