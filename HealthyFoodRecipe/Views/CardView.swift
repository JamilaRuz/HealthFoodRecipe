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
            Image("dessert")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: 200)
            
            VStack {
                Text(category)
                    .font(.headline)
                    .minimumScaleFactor(0.1)
                    .foregroundColor(.primary)
                
                Text("7 favourites")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
            }
            .frame(maxWidth: .infinity, minHeight: 70)
            .background(Color.white) // Set the background color
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
