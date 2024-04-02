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
            
            FavouriteListView()
                .tabItem {
                    Label("Favourites", systemImage: "heart")
                }
        }
    }
}



#Preview {
    ContentView()
        .modelContainer(for: MenuItem.self, inMemory: true)
}
