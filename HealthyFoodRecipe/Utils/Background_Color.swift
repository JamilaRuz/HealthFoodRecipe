//
//  Background_Color.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 3/22/24.
//

import SwiftUI

struct Background_Color: View {
    var body: some View {
        VStack{
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.teal.opacity(0.3)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    Background_Color()
}
