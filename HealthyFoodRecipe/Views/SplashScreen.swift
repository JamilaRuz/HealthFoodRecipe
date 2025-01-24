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
    @State private var titleText = ""
    
    var isPreview: Bool = false
    
    private let fullTitleText = "ПП Рецепты от участниц программы \"Похудейка\""
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
                
                Text(titleText)
                    .font(.custom("HelveticaNeue-CondensedBold", size: 32))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Text(authorText)
                    .font(.custom("AvenirNext-Bold", size: 36))
                    .foregroundColor(.pink2)
            }
            .opacity(opacity)
            .onAppear {
                // Simple fade in
                withAnimation(.easeIn(duration: 0.6)) {
                    self.opacity = 1.0
                }
                
                // Simple text animation
                withAnimation(.easeIn(duration: 0.8)) {
                    titleText = fullTitleText
                }
                
                // Navigate to main content
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    SplashScreen(isPreview: true)
}
