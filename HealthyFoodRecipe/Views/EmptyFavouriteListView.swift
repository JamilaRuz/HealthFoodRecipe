//
//  EmptyView.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 4/11/24.
//

import SwiftUI

struct EmptyFavouriteListView: View {
    let emptyText: String
    
    var body: some View {
        VStack(alignment: .center) {
            Image("logo1")
                .resizable()
                .frame(width: 200, height: 200)
                .scaledToFit()
            Text(emptyText)
                .padding()
                .font(.title3)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(colors: [.pink3, .pink1, .white], startPoint: .top, endPoint: .bottom)
        )
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    EmptyFavouriteListView(emptyText: "Чтобы добавть рецепт в избранное, нажмите на сердечко на самом рецепте.")
}
