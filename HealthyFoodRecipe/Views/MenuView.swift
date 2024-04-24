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
                    EmptyView(emptyText: "Здесь должно быть меню составленное на неделю. Добавить блюда в меню можно, выбрав конкретное блюдо.")
                } else {
                    Text("Меню на неделю")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                    List {
                        ForEach(Day.allCases, id: \.self) { weekday in
                            Section(
                                header: Text("\(weekday.displayName)")
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
                LinearGradient(colors: [.pink3, .pink1, .white], startPoint: .top, endPoint: .bottom)
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
