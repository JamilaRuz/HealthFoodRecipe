//
//  AboutUsView.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 10/25/24.
//

import SwiftUI

struct AboutUsView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Spacer(minLength: 50)
                
                Text("О нас")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("green1"))
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
                    Text("ваш надежный помощник на пути к стройности и здоровому питанию!\n\n Меня зовут Дилек Умарова, я сертифицированный нутрициолог и мама четверых детей. Уже более десяти лет я помогаю женщинам по всему миру находить баланс между заботой о близких и вниманием к своему здоровью и красоте. \n\n В нашем приложении вы найдете только авторские рецепты, разработанные и проверенные участницами нашего сообщества. Эти рецепты не взяты из интернета — каждое блюдо создано с учетом принципов правильного питания и помогает сбрасывать вес, не отказываясь от вкусной еды. Кроме того, все рецепты готовятся очень быстро, не требуют сложных ингредиентов и легко впишутся в расписание даже самых занятых мам. Они питательны, вкусны и идеально подходят для тех, кто хочет поддерживать себя в форме и вдохновлять своих близких на здоровый образ жизни. \n\n Каждый рецепт — это шаг к вашему новому Я. Все в ваших руках, а мы с радостью поможем вам достичь желаемых результатов! \n\n Хотите пройти программу похудения с нами? Посетите наш сайт:")
                   
                    VStack(spacing: 15) {
                        SocialLinkButton(imageName: "globe", url: "https://dileknutrition.com", label: "Website")
                    }
                    Text("- там вас ждут отзывы, истории успеха и программы на любой бюджет.")
                    
                }
                .font(.body)
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .padding()
                .background(colorScheme == .dark ? Color(red: 0.5, green: 0, blue: 0.5).opacity(0.3) : Color("pink3").opacity(0.1))                .cornerRadius(10)
                
                Spacer()
            }
            .padding()
        }
        .background(
            Image("bg_pink")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .opacity(colorScheme == .dark ? 0.1 : 0.3)
                .overlay(colorScheme == .dark ? Color.black.opacity(0.6) : Color.clear)
        )
        .edgesIgnoringSafeArea(.top)
    }
}

struct SocialLinkButton: View {
    @Environment(\.colorScheme) var colorScheme
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
            .foregroundColor(colorScheme == .dark ? .white : Color("green1"))
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(colorScheme == .dark ? Color.white.opacity(0.2) : Color.white.opacity(0.7))
            .cornerRadius(20)
        }
    }
}

#Preview {
    AboutUsView()
}
