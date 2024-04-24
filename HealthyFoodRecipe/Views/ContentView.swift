//
//  ContentView.swift
//  HealthFoodRecipe
//
//  Created by Jamila Ruzimetova on 3/19/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            CategoryListView()
                .tabItem {
                    Label("Categories", systemImage: "fork.knife.circle")
                }
            
            MenuView()
                .tabItem {
                    Label("Weekly menu", systemImage: "menucard")
                }
            
            FavouriteListView(emptyText: "")
                .tabItem {
                    Label("Favourites", systemImage: "heart")
                }
        }
        .onAppear() {
            UITabBar.appearance().backgroundColor = UIColor(.pink1)
        }
    }
}



#Preview {
    ContentView()
        .modelContainer(for: MenuItem.self, inMemory: true)
}
