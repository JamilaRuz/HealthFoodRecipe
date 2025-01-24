import Foundation

struct Category: Codable, Hashable {
    var name: String
    var image: String
}

func getCategoryAssetName(for category: String) -> String {
  switch category {
  case "Завтраки":
    return "breakfast"
  case "Обеды":
    return "lunch"
  case "Ужины":
    return "dinner"
  case "Супы":
    return "soup"
  case "Салаты":
    return "salad"
  case "Выпечка":
    return "baking"
  case "Перекусы":
    return "appetizer"
  case "Десерты":
    return "dessert"
  default:
    return "placeholder"
  }
}

func getAllCategories() -> [Category] {
  [
    Category(name: "Завтраки", image: "breakfast"),
    Category(name: "Обеды", image: "lunch"),
    Category(name: "Ужины", image: "dinner"),
    Category(name: "Супы", image: "soup"),
    Category(name: "Салаты", image: "salad"),
    Category(name: "Выпечка", image: "baking"),
    Category(name: "Перекусы", image: "appetizer"),
    Category(name: "Десерты", image: "dessert")
  ]
}
