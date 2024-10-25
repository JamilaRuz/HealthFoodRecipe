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
                
                Text("О нас")
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
                    
                        Text("Dileknutrition Healthy Recipes - ")
                            .fontWeight(.bold) +
                    Text("ваш надежный помощник на пути к стройности и здоровому питанию!\n\n Меня зовут Дилек Умарова, я сертифицированный нутрициолог и мама четверых детей. Уже более десяти лет я помогаю женщинам по всему миру находить баланс между заботой о близких и вниманием к своему здоровью и красоте. \n\n В приложении вы найдете уникальные рецепты, разработанные и проверенные участницами нашего сообщества. Эти блюда легко готовить, они вкусны и питательны — идеальный выбор для занятых мам, которые хотят поддерживать себя в форме и вдохновлять своих близких на здоровое питание. \n\n Хотите пройти программу похудения с нами?")
                    Text("Посетите наш сайт:")
                    VStack(spacing: 15) {
                        SocialLinkButton(imageName: "globe", url: "https://dileknutrition.com", label: "Website")
                    }
                    
                    Text("Там вас ждут отзывы, истории успеха и программы на любой бюджет.")
                    Text("Каждый рецепт — это шаг к вашему новому Я. Все в ваших руках, а мы с радостью поможем вам достичь желаемых результатов!.")
                        .fontWeight(.semibold)
                }
                .font(.body)
                .foregroundColor(.black)
                .padding()
                .background(Color.pink3.opacity(0.1))
                .cornerRadius(10)
                
                Spacer()
                
                
            }
            .padding()
        }
//        .background(
//            LinearGradient(colors: [.pink2, .pink1, .white], startPoint: .top, endPoint: .bottom)
//        )
//        .background(Color.pink1)
        .background(
            Image("bg_pink")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .opacity(0.3)
        )
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
