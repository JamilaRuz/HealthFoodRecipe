//
//  CarouselView.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 4/5/24.
//

import SwiftUI

struct CarouselView: View {
    let images = ["dessert", "dish", "garnish", "salad", "soup"]
//    let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    @State private var selectedImageIndex: Int = 0
    let screenMidX = UIScreen.main.bounds.midX
    
    var body: some View {
        ScrollViewReader { value in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 5) {
                    ForEach(images.indices, id: \.self) { index in
                        GeometryReader { geometry in
                            Image(images[index])
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, maxHeight: 150)
                                .tag(index)
                                .onChange(of: geometry.frame(in: .global).midX) { _, newValue in
                                    if abs(newValue - screenMidX) < screenMidX / 2 && selectedImageIndex != index {
                                        selectedImageIndex = index
                                    }
                                }
                        }
                        .frame(width: 400, height: 150)
                    }
                }
                .onChange(of: selectedImageIndex) { _, newValue in
                    value.scrollTo(newValue, anchor: .center)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 150)
        .cornerRadius(10)
        .shadow(radius: 20)

       
//        Create navigation dots
        
        HStack {
            ForEach(images.indices, id: \.self) { index in
                Capsule()
                    .fill(Color.darkPink.opacity(selectedImageIndex == index ? 1 : 0.33))
                    .frame(width: 35, height: 8)
                    .onTapGesture {
                        selectedImageIndex = index
                    }
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
    
}

#Preview {
    CarouselView()
}
