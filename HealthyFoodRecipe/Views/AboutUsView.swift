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
            VStack(alignment: .center, spacing: 20) {
                Spacer(minLength: 50)
                
                Text("О нас")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("green1"))
                    .padding(.top, 20)
                
                HStack {
                    Image("dilek")
                        .resizable()
                        .frame(width: 130, height: 200)
                        .aspectRatio(contentMode: .fill)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                VStack(spacing: 10) {
                    (Text("Dileknutrition Healthy Recipes - ")
                        .fontWeight(.bold) +
                    Text("ваш надежный помощник в мире вкусной и полезной еды для всей семьи!\n\n Меня зовут Дилек Умарова, я сертифицированный нутрициолог и мама четверых детей. Уже более десяти лет я помогаю женщинам по всему миру находить свой путь к здоровью и красоте, сохраняя баланс между семьей и работой. \n Я понимаю, как важно найти что-то, что легко впишется в повседневную жизнь, и созданное мною приложение станет для вас идеальным решением. \n\n Dileknutrition Healthy Recipes — это простые и вкусные рецепты, которые помогают худеть с удовольствием, без сложных ингредиентов и долгих часов на кухне. \n\n Каждую неделю мы пополняем коллекцию новыми рецептами, чтобы у вас всегда было что-то интересное и вдохновляющее! \n\n Каждое блюдо — это шаг к здоровому телу! \n\n Попробуйте и убедитесь, что правильное питание может быть легким, приятным и доступным. \n\n Приятного аппетита!\n\n А если хотите ещё больше поддержки и вдохновения — заходите на:"))
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                    
                    VStack(spacing: 15) {
                        SocialLinkButton(imageName: "globe", url: "https://dileknutrition.com", label: "Website")
                    }
                    
                    Text("- где вас ждут отзывы, вдохновляющие истории успеха и программы на любой бюджет!")
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
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
