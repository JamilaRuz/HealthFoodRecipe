//
//  ContentView.swift
//  HealthFoodRecipe
//
//  Created by Jamila Ruzimetova on 3/19/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    init() {
        let appearance = UISearchBar.appearance()
        appearance.barTintColor = UIColor(.pink1)
        if let textfield = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]) as? UITextField {
            textfield.backgroundColor = UIColor.white // Adjust if needed
        }
    }
        
    var body: some View {
        TabView {
            CategoryListView()
                .tabItem {
                    Label("Категории", systemImage: "fork.knife.circle")
                }
            
            MenuView()
                .tabItem {
                    Label("Меню на неделю", systemImage: "menucard")
                }
            
            FavouriteListView(emptyText: "")
                .tabItem {
                    Label("Избранные", systemImage: "heart")
                }
        }
        .onAppear() {
//            UINavigationBar.appearance().backgroundColor = UIColor(.pink1)
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(.white)]
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: MenuItem.self, inMemory: true)
}
