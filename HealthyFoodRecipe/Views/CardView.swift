//
//  CardView.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 3/22/24.
//

import SwiftUI
import SwiftData

struct CardView: View {
    let category: Category

    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Image(category.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 120)
            .overlay(alignment: .bottom) {
                Text(category.name)
                    .font(.headline)
                    .minimumScaleFactor(0.1)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 3, x: 0, y: 0)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
        }
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
  CardView(category: createStubRecipes()[0].category)
    .environment(\.modelContext, createPreviewModelContainer().mainContext)
}
