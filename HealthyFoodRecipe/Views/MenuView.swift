//
//  MenuView.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 4/2/24.
//

import SwiftUI
import SwiftData

struct MenuView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var menuItems: [MenuItem]
    
    var body: some View {
        NavigationView {
            VStack {
                if menuItems.isEmpty {
                    VStack(alignment: .center) {
                        Image("logo1")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .scaledToFit()
                        Text("No recipe is chosen for the week's menu, please go to the main page and choose your favorite dish!")
                            .padding()
                            .font(.title3)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    Text("Menu of the week")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                    List {
                        ForEach(Day.allCases, id: \.self) { weekday in
                            Section(
                                header: Text("\(weekday)")
                                    .font(.body)
                            ) {
                                ForEach(menuItems) { menuItem in
                                    if menuItem.day == weekday.rawValue {
                                        MenuItemView(menuItem: menuItem)
                                    }
                                }
                                .listRowSeparatorTint(.pink)
                            }//section
                        }
                        
                    } //list
                } //else
            } //Vstack main
            .navigationBarTitleDisplayMode(.inline)
            .scrollContentBackground(.hidden)
            .background(
                LinearGradient(colors: [.darkPink, .lightPink, .white], startPoint: .top, endPoint: .bottom)
            )
        }// nav view
    }//body
}

struct MenuItemView: View {
    @Environment(\.modelContext) private var modelContext
    var menuItem: MenuItem

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(menuItem.recipe?.name ?? "")
                    .lineLimit(1)
                    .font(.callout)
                    .bold()
                    .opacity(menuItem.isChecked ? 0.3 : 1.0)
                Text("(\(menuItem.recipe?.category.name ?? ""))")
                    .foregroundStyle(.secondary)
                    .font(.caption)
            }
            
            Spacer()
            
            Image(systemName: menuItem.isChecked ? "checkmark.circle.fill" : "circle")
                .foregroundColor(.purple)
                .padding()
                .onTapGesture {
                    withAnimation(
                        .easeInOut(duration: 2.0),
                        {
                            menuItem.isChecked.toggle()
                        },
                        completion: {
                            modelContext.delete(menuItem)
                        }
                    )
                }
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    MenuView()
        .modelContainer(for: MenuItem.self, inMemory: false)
}
