//
//  LandingView.swift
//  HealthFoodRecipe
//
//  Created by Jamila Ruzimetova on 3/20/24.
//

import SwiftUI
import SwiftData

struct LandingView: View {
    
    var body: some View {
        TabView {
            CategoryListView()
                .tabItem {
                    Label("Categories", systemImage: "fork.knife.circle")
                }
            
            ContentView()
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
    LandingView()
}
