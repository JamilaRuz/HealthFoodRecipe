//
//  ActivationView.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 5/31/24.
//

import SwiftUI

import SwiftUI

struct ActivationView: View {
  @Environment(\.modelContext) var modelContext
  @Environment(\.presentationMode) var presentationMode
  
  @State private var activationCode: String = ""
  
  @State private var showAlert: Bool = false
  @State private var isSuccess: Bool = false

  var body: some View {
    NavigationStack {
      VStack {
        Text("Если вы являетесь участником группы Похудейка, то администратор группы может предоставить вам код активации, чтобы иметь возможность видеть все рецепты.")
        
        TextField("Код активации", text: $activationCode)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding()
        
        Button("Активировать приложение") {
          print("Activation requested with code: \(activationCode)")
          Task {
            do {
              try await ActivationManager().activateApp(activationCode: activationCode)
              await DataImporter(modelContext: modelContext).importData(resetLastChangeTime: true)
              isSuccess = true
            } catch {
              print("Error activating app: \(error)")
              isSuccess = false
            }
            showAlert = true
          }
        }
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
      .padding()
    }
  }
}

#Preview {
  ActivationView()
    .environment(\.modelContext, createPreviewModelContainer().mainContext)
}
