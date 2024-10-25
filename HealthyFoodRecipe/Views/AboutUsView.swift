//
//  AboutUsView.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 10/25/24.
//

import SwiftUI

struct AboutUsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Spacer(minLength: 50)
                
                Text("О проекте")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.green1)
                    .padding(.top, 20)
                
                HStack {
                    Image("dilek")
                        .resizable()
                        .frame(width: 100, height: 150)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                }
                
                VStack(spacing: 10) {
                    Text("Lorem ipsum dolor sit amet. Et doloremque delectus et consequatur inventore et earum accusamus et cumque perspiciatis et veniam consectetur est nemo nihil.")
                    Text("Lorem ipsum dolor sit amet. Et doloremque delectus et consequatur inventore et earum accusamus et cumque perspiciatis et veniam consectetur est nemo nihil.")
                    Text("Lorem ipsum dolor sit amet. Et doloremque delectus et consequatur inventore et earum accusamus et cumque perspiciatis et veniam consectetur est nemo nihil.")
                }
                .font(.body)
                .foregroundColor(.black)
                .padding()
                .background(Color.white.opacity(0.5))
                .cornerRadius(10)
                
                Spacer()
                
                VStack(spacing: 15) {
                    SocialLinkButton(imageName: "globe", url: "https://dileknutrition.com", label: "Website")
                }
                .padding(.bottom)
            }
            .padding()
        }
        .background(
            LinearGradient(colors: [.pink2, .pink1, .white], startPoint: .top, endPoint: .bottom)
        )
//        .background(Color.pink1)
        .edgesIgnoringSafeArea(.top)
    }
}

struct SocialLinkButton: View {
    let imageName: String
    let url: String
    let label: String
    
    var body: some View {
        Button(action: {
            if let url = URL(string: url) {
                UIApplication.shared.open(url)
            }
        }) {
            HStack {
                Image(systemName: imageName)
                    .font(.title2)
                Text(label)
                    .font(.body)
            }
            .foregroundColor(.green1)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color.white.opacity(0.7))
            .cornerRadius(20)
        }
    }
}

#Preview {
    AboutUsView()
}
