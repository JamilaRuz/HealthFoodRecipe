//
//  CardView.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 3/22/24.
//

import SwiftUI
import SwiftData

struct CardView: View {
    let category: String
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Image("meat")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay(alignment: .bottom) {
                        Text(category)
                            .font(.headline)
//                            .minimumScaleFactor(0.1)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 3, x: 0, y: 0)
                            .frame(maxWidth: 150)
                            .padding()
                    }
            }
        }
        .cornerRadius(10) // Add rounded corners
        .shadow(radius: 5) // Add a subtle shadow
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(category: "Salads and dressings")
            .previewLayout(.sizeThatFits)
    }
}
