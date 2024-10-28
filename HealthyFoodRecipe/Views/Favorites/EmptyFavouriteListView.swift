//
//  EmptyView.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 4/11/24.
//

import SwiftUI

struct EmptyFavouriteListView: View {
    let emptyText: String
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .center) {
            Image("logo1")
                .resizable()
                .frame(width: 200, height: 200)
                .scaledToFit()
            Text(emptyText)
                .padding()
                .font(.title3)
                .foregroundColor(colorScheme == .dark ? .white : .gray)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Group {
                if colorScheme == .dark {
                    LinearGradient(
                        colors: [Color(red: 0.2, green: 0.1, blue: 0.2), Color.black],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                } else {
                    LinearGradient(
                        colors: [Color("pink2"), Color("pink1"), .white],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
            }
        )
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    Group {
        EmptyFavouriteListView(emptyText: "Чтобы добавть рецепт в избранное, нажмите на сердечко на самом рецепте.")
            .preferredColorScheme(.light)
        
        EmptyFavouriteListView(emptyText: "Чтобы добавть рецепт в избранное, нажмите на сердечко на самом рецепте.")
            .preferredColorScheme(.dark)
    }
}
