//
//  ActivationView.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 5/31/24.
//

import SwiftUI

import SwiftUI

struct ActivationView: View {
  @Binding var isAppActivated: Bool
  
  @Environment(\.modelContext) var modelContext
  @Environment(\.presentationMode) var presentationMode
  
  @State private var activationCode: String = ""
  
  @State private var showAlert: Bool = false
  @State private var isSuccess: Bool = false
  
  var body: some View {
    NavigationStack {
      VStack(spacing: 20) {
        Image("logo2")
          .resizable()
          .scaledToFit()
          .frame(width: 200, height: 200)
        
        Text("Если вы являетесь участником группы Похудейка, то администратор группы может предоставить вам код активации, чтобы иметь возможность видеть все рецепты.")
          .foregroundColor(.gray)
          .multilineTextAlignment(.center)
        
        TextField("Код активации", text: $activationCode)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding()
        
        Button("Активировать") {
          print("Activation requested with code: \(activationCode)")
          Task {
            do {
              try await ActivationManager().activateApp(activationCode: activationCode)
              await DataImporter(modelContext: modelContext).importData(resetLastChangeTime: true)
              self.isAppActivated = true
              isSuccess = true
            } catch {
              print("Error activating app: \(error)")
              isSuccess = false
            }
            showAlert = true
          }
        }
        .frame(width: 150, height: 50)
        .background(LinearGradient(colors: [.pink3, .pink2], startPoint: .top, endPoint: .bottom))
        .cornerRadius(10)
        .foregroundColor(.white)
        
        .alert(isPresented: $showAlert) {
          if (isSuccess) {
            return Alert(title: Text("Активация приложения"), message: Text("Приложение успешно активировано"), dismissButton: .default(Text("OK")) {
              presentationMode.wrappedValue.dismiss()
            })
          } else {
            return Alert(title: Text("Ошибка активации"), message: Text("Проверьте правильность введенного кода или обратитесь к администору группы за другим кодом активации"), dismissButton: .default(Text("OK")))
          }
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .padding()
      .background(Color.pink1)
    } // NavigationStack
    .navigationTitle("Активация")
    .navigationBarTitleDisplayMode(.inline)
  }
}

#Preview {
  ActivationView(isAppActivated: .constant(false))
    .environment(\.modelContext, createPreviewModelContainer().mainContext)
}
