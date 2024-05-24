//
//  Weekdays.swift
//  HealthFoodRecipe
//
//  Created by Jamila Ruzimetova on 3/19/24.
//

import Foundation

enum Day: String, CaseIterable {
  case Monday,
       Tuesday,
       Wednesday,
       Thursday,
       Friday,
       Saturday,
       Sunday
  
  var displayName: String {
    switch self {
    case .Monday: return "Понедельник"
    case .Tuesday: return "Вторник"
    case .Wednesday: return "Среда"
    case .Thursday: return "Четверг"
    case .Friday: return "Пятница"
    case .Saturday: return "Суббота"
    case .Sunday: return "Восресенье"
    }
  }
}
