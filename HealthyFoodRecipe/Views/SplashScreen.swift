//
//  AboutUsView.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 10/25/24.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            VStack {
                VStack(spacing: 30) {
                    Image("logo2")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                    
                    Text("ПП Рецепты от участниц программы \"Похудейка\"")
                        .font(.custom("Noteworthy-Light", size: 30))
                        .fontWeight(.regular)
                        .foregroundColor(.pink2)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Text("с Дилек Умаровой")
                        .padding()
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .border(.black, width: 2)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image("bg_pink")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .opacity(0.3)
            )
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreen()
}
