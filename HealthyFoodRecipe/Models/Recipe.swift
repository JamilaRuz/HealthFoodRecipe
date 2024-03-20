//
//  Recipe.swift
//  HealthFoodRecipe
//
//  Created by Jamila Ruzimetova on 3/19/24.
//

import Foundation
import SwiftData

@Model
class Recipe: Identifiable {
    let id = UUID()
    
    let Title: String?
    let Directions: String?
    
    let Quantity: Int?
    let Unit01: String?
    let Ingredient01: String?
    
    let Quantity02: Int?
    let Unit02: String?
    let Ingredient02: String?
    
    let Quantity03: Int?
    let Unit03: String?
    let Ingredient03: String?
    
    let Quantity04: Int?
    let Unit04: String?
    let Ingredient04: String?
    
    let Quantity05: Int?
    let Unit05: String?
    let Ingredient05: String?
    
    let Quantity06: Int?
    let Unit06: String?
    let Ingredient06: String?
    
    let Quantity07: Int?
    let Unit07: String?
    let Ingredient07: String?
    
    let Quantity08: Int?
    let Unit08: String?
    let Ingredient08: String?
    
    let Quantity09: Int?
    let Unit09: String?
    let Ingredient09: String?
    
    let Quantity10: Int?
    let Unit10: String?
    let Ingredient10: String?
    
    let Quantity11: Int?
    let Unit11: String?
    let Ingredient11: String?
    
    let Quantity12: Int?
    let Unit12: String?
    let Ingredient12: String?
    
    let Quantity13: Int?
    let Unit13: String?
    let Ingredient13: String?
    
    let Quantity14: Int?
    let Unit14: String?
    let Ingredient14: String?
    
    let Quantity15: Int?
    let Unit15: String?
    let Ingredient15: String?
    
    let Quantity16: Int?
    let Unit16: String?
    let Ingredient16: String?
    
    let Quantity17: Int?
    let Unit17: String?
    let Ingredient17: String?
    
    let Quantity18: Int?
    let Unit18: String?
    let Ingredient18: String?
    
    let Quantity19: Int?
    let Unit19: String?
    let Ingredient19: String?
    
    let Category: String?
    
    init(Title: String, Directions: String, Quantity: Int, Unit01: String, Ingredient01: String, Quantity02: Int, Unit02: String, Ingredient02: String, Quantity03: Int, Unit03: String, Ingredient03: String, Quantity04: Int, Unit04: String, Ingredient04: String, Quantity05: Int, Unit05: String, Ingredient05: String, Quantity06: Int, Unit06: String, Ingredient06: String, Quantity07: Int, Unit07: String, Ingredient07: String, Quantity08: Int, Unit08: String, Ingredient08: String, Quantity09: Int, Unit09: String, Ingredient09: String, Quantity10: Int, Unit10: String, Ingredient10: String, Quantity11: Int, Unit11: String, Ingredient11: String, Quantity12: Int, Unit12: String, Ingredient12: String, Quantity13: Int, Unit13: String, Ingredient13: String, Quantity14: Int, Unit14: String, Ingredient14: String, Quantity15: Int, Unit15: String, Ingredient15: String, Quantity16: Int, Unit16: String, Ingredient16: String, Quantity17: Int, Unit17: String, Ingredient17: String, Quantity18: Int, Unit18: String, Ingredient18: String, Quantity19: Int, Unit19: String, Ingredient19: String, Category: String) {
        self.Title = Title
        self.Directions = Directions
        self.Quantity = Quantity
        self.Unit01 = Unit01
        self.Ingredient01 = Ingredient01
        self.Quantity02 = Quantity02
        self.Unit02 = Unit02
        self.Ingredient02 = Ingredient02
        self.Quantity03 = Quantity03
        self.Unit03 = Unit03
        self.Ingredient03 = Ingredient03
        self.Quantity04 = Quantity04
        self.Unit04 = Unit04
        self.Ingredient04 = Ingredient04
        self.Quantity05 = Quantity05
        self.Unit05 = Unit05
        self.Ingredient05 = Ingredient05
        self.Quantity06 = Quantity06
        self.Unit06 = Unit06
        self.Ingredient06 = Ingredient06
        self.Quantity07 = Quantity07
        self.Unit07 = Unit07
        self.Ingredient07 = Ingredient07
        self.Quantity08 = Quantity08
        self.Unit08 = Unit08
        self.Ingredient08 = Ingredient08
        self.Quantity09 = Quantity09
        self.Unit09 = Unit09
        self.Ingredient09 = Ingredient09
        self.Quantity10 = Quantity10
        self.Unit10 = Unit10
        self.Ingredient10 = Ingredient10
        self.Quantity11 = Quantity11
        self.Unit11 = Unit11
        self.Ingredient11 = Ingredient11
        self.Quantity12 = Quantity12
        self.Unit12 = Unit12
        self.Ingredient12 = Ingredient12
        self.Quantity13 = Quantity13
        self.Unit13 = Unit13
        self.Ingredient13 = Ingredient13
        self.Quantity14 = Quantity14
        self.Unit14 = Unit14
        self.Ingredient14 = Ingredient14
        self.Quantity15 = Quantity15
        self.Unit15 = Unit15
        self.Ingredient15 = Ingredient15
        self.Quantity16 = Quantity16
        self.Unit16 = Unit16
        self.Ingredient16 = Ingredient16
        self.Quantity17 = Quantity17
        self.Unit17 = Unit17
        self.Ingredient17 = Ingredient17
        self.Quantity18 = Quantity18
        self.Unit18 = Unit18
        self.Ingredient18 = Ingredient18
        self.Quantity19 = Quantity19
        self.Unit19 = Unit19
        self.Ingredient19 = Ingredient19
        
        self.Category = Category
    }
}

func cleanRows(file: String) -> String {
    let cleanFile = file
        .replacingOccurrences(of: "\r", with: "\n")
        .replacingOccurrences(of: "\n\n", with: "\n")
    
    return cleanFile
}

func loadRecipe() -> [Recipe] {
    var listOfRecipes = [Recipe]()
    
    guard let filePath = Bundle.main.path(forResource: "recipes", ofType: "csv") else {
        fatalError("File not found")
    }
    
    var data = ""
    
    do {
        data = try String(contentsOf: URL(fileURLWithPath: filePath))
    } catch {
        print(error)
        return []
    }
    
    data = cleanRows(file: data)
    
    var rows = data.components(separatedBy: "\n")
    let columnCount = rows.first?.components(separatedBy: ",").count
    
    rows.removeFirst()
    
    for row in rows {
        let columns = row.components(separatedBy: ",")
        if columns.count == columnCount {
            let thisRecipe = Recipe(
                Title: columns[0],
                Directions: columns[1],
                Quantity: Int(columns[2]) ?? 0,
                Unit01: columns[3],
                Ingredient01: columns[4],
                Quantity02: Int(columns[5]) ?? 0,
                Unit02: columns[6],
                Ingredient02: columns[7],
                Quantity03: Int(columns[8]) ?? 0,
                Unit03: columns[9],
                Ingredient03: columns[10],
                Quantity04: Int(columns[11]) ?? 0,
                Unit04: columns[12],
                Ingredient04: columns[13],
                Quantity05: Int(columns[14]) ?? 0,
                Unit05: columns[15],
                Ingredient05: columns[16],
                Quantity06: Int(columns[17]) ?? 0,
                Unit06: columns[18],
                Ingredient06: columns[19],
                Quantity07: Int(columns[20]) ?? 0,
                Unit07: columns[21],
                Ingredient07: columns[22],
                Quantity08: Int(columns[23]) ?? 0,
                Unit08: columns[24],
                Ingredient08: columns[25],
                Quantity09: Int(columns[26]) ?? 0,
                Unit09: columns[27],
                Ingredient09: columns[28],
                Quantity10: Int(columns[29]) ?? 0,
                Unit10: columns[30],
                Ingredient10: columns[31],
                Quantity11: Int(columns[32]) ?? 0,
                Unit11: columns[33],
                Ingredient11: columns[34],
                Quantity12: Int(columns[35]) ?? 0,
                Unit12: columns[36],
                Ingredient12: columns[37],
                Quantity13: Int(columns[38]) ?? 0,
                Unit13: columns[39],
                Ingredient13: columns[40],
                Quantity14: Int(columns[41]) ?? 0,
                Unit14: columns[42],
                Ingredient14: columns[43],
                Quantity15: Int(columns[44]) ?? 0,
                Unit15: columns[45],
                Ingredient15: columns[46],
                Quantity16: Int(columns[47]) ?? 0,
                Unit16: columns[48],
                Ingredient16: columns[49],
                Quantity17: Int(columns[50]) ?? 0,
                Unit17: columns[51],
                Ingredient17: columns[52],
                Quantity18: Int(columns[53]) ?? 0,
                Unit18: columns[54],
                Ingredient18: columns[55],
                Quantity19: Int(columns[56]) ?? 0,
                Unit19: columns[57],
                Ingredient19: columns[58],
                Category: columns[59]
            )
            listOfRecipes.append(thisRecipe)
        }
    }
    
    return listOfRecipes
}

let recipes = loadRecipe()
