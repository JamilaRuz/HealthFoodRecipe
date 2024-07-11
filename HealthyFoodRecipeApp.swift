//
//  HealthFoodRecipeApp.swift
//  HealthFoodRecipe
//
//  Created by Jamila Ruzimetova on 3/19/24.
//

import SwiftUI
import SwiftData
import CoreData


@main
struct HealthyFoodRecipeApp: App {
  static let refreshIntervalSeconds: TimeInterval = 5 * 60

  @Environment(\.scenePhase) private var scenePhase
  
  let container = try! ModelContainer(for: Recipe.self)
  
  private let timer = Timer.publish(every: refreshIntervalSeconds, on: .main, in: .common).autoconnect()
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .onReceive(timer) { _ in
          refreshDataFromServer()
        }
    }
    .modelContainer(container)
    .onChange(of: scenePhase, initial: false) { oldPhase, newPhase in
      if newPhase == .active {
        refreshDataFromServer()
      }
    }
  }
  
  private func refreshDataFromServer() {
    Task { @MainActor in
      await DataImporter(modelContext: container.mainContext).importData(resetLastChangeTime: false)
    }
  }
}
