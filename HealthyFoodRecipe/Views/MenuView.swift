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
    @Query var recipes: [Recipe]
    
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
                            .font(.title)
                            .foregroundColor(.white)
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
                                    .foregroundColor(.white)
                                    .shadow(radius: 5)
                            ) {
                                ForEach(menuItems) { menuItem in
                                    if menuItem.day == weekday.rawValue {
                                        HStack {
                                            VStack(alignment: .leading, spacing: 5) {
                                                Text(menuItem.recipeName ?? "")
                                                    .lineLimit(1)
                                                    .font(.callout)
                                                    .bold()
                                                    .opacity(menuItem.isChecked ? 0.3 : 1.0)
                                                Text("(\(getCategory(for: menuItem.recipeName ?? "")))")
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
                                .listRowSeparatorTint(.pink)
                            }//section
                        }

                    } //list
                } //else
            } //Vstack main
            .navigationBarTitleDisplayMode(.inline)
            .scrollContentBackground(.hidden)
            .background(
                //                Image("fruits-bg")
                //                    .resizable()
                //                    .scaledToFill()
                //                    .blur(radius: 3)
                //                    .overlay(Color.indigo.opacity(0.1))
                //                    .ignoresSafeArea(.container)
                LinearGradient(colors: [.darkPurple, .darkPink, .white], startPoint: .top, endPoint: .bottom)
            )
        }// nav view
    }//body
    
    func getCategory(for recipe: String) -> String {
        let thisRecipe = recipes.first(where: {$0.name == recipe})
        
        return thisRecipe?.category ?? "None"
    }
}

#Preview {
    MenuView()
        .modelContainer(for: MenuItem.self, inMemory: false)
}
