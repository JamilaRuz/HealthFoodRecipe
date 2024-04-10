//
//  CarouselView.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 4/5/24.
//

import SwiftUI

struct CarouselView: View {
    @State private var selectedImageIndex: Int = 0
    
    let images = ["dessert", "dish", "garnish", "salad", "soup"]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack(spacing: 0) {
                ForEach(images, id: \.self) { image in
                    Image(image)
                        .scaledToFill()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 150)
        .cornerRadius(10)
        .shadow(radius: 10)
        
        HStack {
            ForEach(0..<images.count, id: \.self) { index in
                // Step 13: Create Navigation Dots
                Capsule()
                    .fill(Color.darkPink.opacity(selectedImageIndex == index ? 1 : 0.33))
                    .frame(width: 35, height: 8)
                    .onTapGesture {
                        // Step 14: Handle Navigation Dot Taps
                        selectedImageIndex = index
                    }
            }
            .offset(y: 5) // Step 15: Adjust Dots Position
        }
    }
    
}

#Preview {
    CarouselView()
}
