//
//  StubData.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 4/17/24.
//

import Foundation
import SwiftData

@MainActor func createPreviewModelContainer() -> ModelContainer {
  let schema = Schema([Recipe.self, MenuItem.self])
  let modelConfiguration = ModelConfiguration(isStoredInMemoryOnly: true)
  let container: ModelContainer
  
  do {
    container = try ModelContainer(for: schema, configurations: modelConfiguration)
    
    let context = container.mainContext
    
    let recipes = createStubRecipes()
    for recipe in recipes {
      context.insert(recipe)
    }
    
    try context.save()
  } catch {
    fatalError("Failed to load preview container: \(error)")
  }
  
  return container
}

func createStubRecipes() -> [Recipe] {
  [
    Recipe(
      id: 1,
      name: "Поке постное",
      images: ["salad.jpg"],
      ingredients: "Авокадо - 0.25 шт, Огурец - 0.25 шт, Кукуруза в початках или в банке без сахара - 2 ст.л, Рыбка солёная - 30 гр",
      instructions: "Ингредиенты нарезать кубиками и сложить в миску. Перед употреблением перемешать.",
      category: Category(name: "Салаты", image: "salad"),
      isFavorite: false
    ),
    Recipe(
      id: 2,
      name: "Кукурузная лепешка с сыром",
      images: ["salad.jpg"],
      ingredients: """
      1. Кефир - 100 мл
      2. Кукурузная мука - 50 гр
      3. Яйцо - 1 шт
      4. Сыр - 50 гр
      5. Зелень - 10 гр
      """,
      instructions: "Все перемешать, сыр на крупной тёрке потереть и добавить в смесь. Жарить на медленном огне, затем дать остыть. Получается 2 лепешки.",
      category: Category(name: "Завтраки", image: "breakfast"),
      isFavorite: false
    ),
    Recipe(
      id: 3,
      name: "Protein Waffles",
      images: ["dessert1"],
      ingredients: "eggs - 6 items, cottage cheese - 2 cups, old fashioned oats - 2 cups, vanilla extract - 0.25 tsp",
      instructions: "Preheat a waffle iron. Lightly coat with nonstick spray. Combine eggs, cottage cheese, oats, vanilla and salt in blender until smooth. Pour a scant 1/2 cup of the egg mixture into the waffle iron, close gently and cook until golden brown and crisp, about 4-5 minutes.",
      category: Category(name: "Десерты", image: "dessert"),
      isFavorite: false
    ),
    Recipe(
      id: 4,
      name: "Пицца Маргарита",
      images: ["dish1"],
      ingredients: "Грибы Портабелла, базилик, соль, перец, чеснок - 12 pkg, помидоры черри - 3 tbs, моцарелла - 1 tbs, соль - 0.25 ts",
      instructions: "Грибы помыть и промочить бумажным полотенцем, посолить, поперчить и выжать зубчик чеснока (можно чесночную пудру), выложить сверху порезанные пополам помидоры и еже раз посолить и поперчить, сверху положить кубиками нарезанную моцареллу и нарезанный базилик. 400 градусов 20 минут",
      category: Category(name: "Обеды", image: "lunch"),
      isFavorite: false
    ),
    Recipe(
      id: 5,
      name: "Хлеб из творога",
      images: ["baking1"],
      ingredients: "сыр коттедж - 500 гр, овсянка - 300 гр, яйца - 3 шт, разрыхлитель - 1 ч.л, соль - 1 ч.л, семечки - 1 ч.л",
      instructions: "Все перемешать, руками создать форму хлеба и выставить на пергаментную бумагу на противень. Посыпать кунжут, овсянку. Печь на 350 градусов в течение часа примерно.",
      category: Category(name: "Выпечка", image: "baking"),
      isFavorite: false
    ),
    Recipe(
      id: 6,
      name: "Роллы из quinoa",
      images: ["appetizer1"],
      ingredients: "Quinoa - 12 pkg, семга собственного посола - 3 tbs, омлет - 1 tbs, сыр мазалка из low fat кефира - 1 tbs, огурец - 0.25 ts",
      instructions: "Рыбу промыть,променять бумажным полотенцем, посыпать с двух сторон смесью соль с монкфрут. Я иногда сверху кладу 3-4лпвровых листа и пару штук гвоздики( clove). Накрыть контейнер и оставить на кухне. Утром слить всю жидкость и убрать в холодильник. Когда надо кусочек отрезаем и наслаждаемся",
      category: Category(name: "Перекусы", image: "appetizer"),
      isFavorite: false
    ),
    Recipe(
      id: 7,
      name: "Фаршированный перец",
      images: ["garnish1"],
      ingredients: "Луковица - 1 шт, Морковки - 2 шт, чеснока - 2 шт, банка консервированных помидоров или томатного сока - 1 шт, Зелень по вкусу, у меня была кинза - 1 шт, Специи по вкусу ( соль, перец, Чили, орегано, базилик) - 1 tbs, говяжий фарш ( lean 96/4) - 0.50 кг",
      instructions: "Лук и морковку притушить на пару пшиках масла, добавить фарш и немного обжарить на большом огне, добавить /хорошо промытый рис, специи, зелень, добавить половину томатного сока. Начинить перцы. Остальной томатный сок смешиваю с кипятком и заливаю перцы в казане примерно на 3/4. В этот раз готовила в скороварке на режиме low 25 миную.",
      category: Category(name: "Обеды", image: "lunch"),
      isFavorite: false
    ),
    Recipe(
      id: 8,
      name: "Creamy Spinach and Artichoke Soup",
      images: ["soup"],
      ingredients: "extra-firm tofu, drained - 12 pkg, lemon juice - 3 tbs, white wine vinegar - 1 tbs, yellow mustard - 0.25 ts",
      instructions: "Preheat oven to 350°F. Line a 2-quart square baking dish with parchment paper. For filling, in a small saucepan combine figs and 1 cup water. Bring to boiling; reduce heat. Cover and simmer 10 minutes or until figs are soft. Transfer figs and cooking liquid to a blender or food processor. Add lemon juice and vanilla. Cover and blend until smooth.",
      category: Category(name: "Супы", image: "soup"),
      isFavorite: true
    ),
    Recipe(
      id: 9,
      name: "Pumkin Pie",
      images: ["dessert"],
      ingredients: "extra-firm tofu, drained - 12 pkg, lemon juice - 3 tbs, white wine vinegar - 1 tbs, yellow mustard - 0.25 ts",
      instructions: "Preheat oven to 350°F. Line a 2-quart square baking dish with parchment paper. For filling, in a small saucepan combine figs and 1 cup water. Bring to boiling; reduce heat. Cover and simmer 10 minutes or until figs are soft. Transfer figs and cooking liquid to a blender or food processor. Add lemon juice and vanilla. Cover and blend until smooth.",
      category: Category(name: "Десерты", image: "dessert"),
      isFavorite: false
    ),
    Recipe(
      id: 10,
      name: "Creamy Spinach and Artichoke Soup",
      images: ["garnish1"],
      ingredients: "extra-firm tofu, drained - 12 pkg, lemon juice - 3 tbs, white wine vinegar - 1 tbs, yellow mustard - 0.25 ts",
      instructions: "Preheat oven to 350°F. Line a 2-quart square baking dish with parchment paper. For filling, in a small saucepan combine figs and 1 cup water. Bring to boiling; reduce heat. Cover and simmer 10 minutes or until figs are soft. Transfer figs and cooking liquid to a blender or food processor. Add lemon juice and vanilla. Cover and blend until smooth.",
      category: Category(name: "Завтраки", image: "breakfast"),
      isFavorite: true
    ),
    Recipe(
      id: 11,
      name: "Хлеб с семенами",
      images: ["drink1"],
      ingredients: "Минеральная вода - 1 л, лайм - 2 шт, сахзам - 3 ст.л, листья мяты - 10 шт",
      instructions: "Нарезать лайм кружочками. В минеланую воду добавить лайм, сахзам по вкусу, мяты и выдавить сок 2 лаймов. Все перемешать и потреблять добавив лед.",
      category: Category(name: "Выпечка", image: "baking"),
      isFavorite: true
    )
  ]
}
