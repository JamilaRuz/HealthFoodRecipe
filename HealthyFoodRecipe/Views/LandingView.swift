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
            ContentView()
                .tabItem {
                    Label("Weekly menu", systemImage: "menucard")
                }
            
            RecipeListView()
                .tabItem {
                    Label("Recipes", systemImage: "carrot")
                }
        }
    }
}

#Preview {
    LandingView()
}
