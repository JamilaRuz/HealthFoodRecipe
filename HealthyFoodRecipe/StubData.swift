//
//  StubData.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 4/17/24.
//

import Foundation

//let recipes: [Recipe] = [
//    Recipe(
//        name: "Поке постное",
//        image: "salad1",
//        ingredients:
//            [Ingredient(name: "Авокадо", unit: "шт", quantity: 0.25), Ingredient(name: "Огурец", unit: "шт", quantity: 0.25),
//                Ingredient(name: "Кукуруза в початках или в банке без сахара", unit: "ст.л", quantity: 2),
//                Ingredient(name: "Рыбка солёная", unit: "гр", quantity: 30)],
//        directions:
//        "Ингредиенты нарезать кубиками и сложить в миску. Перед употреблением перемешать.",
//        category: Category(name: "Салаты", image: "salad"),
//        isFavorite: false,
//        menuItems: []
//    ),
//    Recipe(
//        name: "Кукурузная лепешка с сыром",
//        image: "breakfast1",
//        ingredients:
//            [
//                Ingredient(name: "кефира  + намного зелени.", unit: "мл", quantity: 100),
//                Ingredient(name: "кукурузная мука", unit: "гр", quantity: 50),
//                Ingredient(name: "яйцо", unit: "шт", quantity: 1),
//                Ingredient(name: "сыра", unit: "гр", quantity: 50),
//                Ingredient(name: "зелень", unit: "гр", quantity: 10)
//            ],
//        directions: "Все перемешать, сыр на крупной тёрке потереть и добавить в смесь. Жарить на медленном огне, затем дать остыть. Получается 2 лепешки.",
//        category: Category(name: "Завтраки", image: "breakfast"),
//        isFavorite: false,
//        menuItems: []
//    ),
//    Recipe(
//        name: "Protein Waffles",
//        image: "dessert1",
//        ingredients:
//            [
//                Ingredient(name: "eggs", unit: "items", quantity: 6),
//                Ingredient(name: "cottage cheese", unit: "cups", quantity: 2),
//                Ingredient(name: "old fashioned oats", unit: "cups", quantity: 2),
//                Ingredient(name: "vanilla extract", unit: "tsp", quantity: 0.25)],
//        directions: "Preheat a waffle iron. Lightly coat with nonstick spray. Combine eggs, cottage cheese, oats, vanilla and salt in blender until smooth. Pour a scant 1/2 cup of the egg mixture into the waffle iron, close gently and cook until golden brown and crisp, about 4-5 minutes.",
//        category: Category(name: "Десерты", image: "dessert"),
//        isFavorite: false,
//        menuItems: []
//    ),
//    Recipe(
//        name: "Пицца Маргарита",
//        image: "dish1",
//        ingredients:
//            [Ingredient(name: "Грибы Портабелла, базилик, соль, перец, чеснок", unit: "pkg", quantity: 12),
//             Ingredient(name: "помидоры черри", unit: "tbs", quantity: 3),
//             Ingredient(name: "моцарелла", unit: "tbs", quantity: 1),
//             Ingredient(name: "соль", unit: "ts", quantity: 0.25)],
//        directions: "Грибы помыть и промочить бумажным полотенцем, посолить, поперчить и выжать зубчик чеснока (можно чесночную пудру), выложить сверху порезанные пополам помидоры и еже раз посолить и поперчить, сверху положить кубиками нарезанную моцареллу и нарезанный базилик. 400 градусов 20 минут",
//        category: Category(name: "Основные блюда", image: "dish"),
//        isFavorite: false,
//        menuItems: []
//    ),
//    Recipe(
//        name: "Хлеб из творога",
//        image: "baking1",
//        ingredients:
//            [
//                Ingredient(name: "сыр коттедж", unit: "гр", quantity: 500),
//                Ingredient(name: "овсянка", unit: "гр", quantity: 300),
//                Ingredient(name: "яйца", unit: "шт", quantity: 3),
//                Ingredient(name: "разрыхлитель", unit: "ч.л", quantity: 1),
//                Ingredient(name: "соль", unit: "ч.л", quantity: 1),
//                Ingredient(name: "семечки", unit: "ч.л", quantity: 1)
//            ],
//        directions: "Все перемешать, руками создать форму хлеба и выставить на пергаментную бумагу на противень. Посыпать кунжут, овсянку. Печь на 350 градусов в течение часа примерно.",
//        category: Category(name: "ПП Выпечка", image: "baking"),
//        isFavorite: false,
//        menuItems: []
//    ),
//    Recipe(
//        name: "Роллы из quinoa",
//        image: "appetizer1",
//        ingredients:
//            [Ingredient(name: "Quinoa", unit: "pkg", quantity: 12),
//             Ingredient(name: "семга собственного посола", unit: "tbs", quantity: 3),
//             Ingredient(name: "омлет", unit: "tbs", quantity: 1),
//             Ingredient(name: "сыр мазалка из low fat кефира", unit: "tbs", quantity: 1),
//             Ingredient(name: "огурец", unit: "ts", quantity: 0.25)],
//        directions: "Рыбу промыть,променять бумажным полотенцем, посыпать с двух сторон смесью соль с монкфрут.  Я иногда сверху кладу 3-4лпвровых листа и пару штук гвоздики( clove). Накрыть контейнер и оставить на кухне. Утром слить всю жидкость и убрать в холодильник.  Когда надо кусочек отрезаем и наслаждаемся",
//        category: Category(name: "Перекусы", image: "appetizer"),
//        isFavorite: false,
//        menuItems: []
//    ),
//    Recipe(
//        name: "Фаршированный перец",
//        image: "garnish1",
//        ingredients:
//            [
//                Ingredient(name: "Луковица", unit: "шт", quantity: 1),
//                        Ingredient(name: "Морковки", unit: "шт", quantity: 2),
//                        Ingredient(name: "чеснока", unit: "шт", quantity: 2),
//                        Ingredient(name: "банка консервированных помидоров или томатного сока", unit: "шт", quantity: 1),
//                        Ingredient(name: "Зелень по вкусу, у меня была кинза", unit: "шт", quantity: 1),
//                        Ingredient(name: "Специи по вкусу ( соль, перец, Чили, орегано, базилик)", unit: "tbs", quantity: 1),
//                        Ingredient(name: "говяжий фарш ( lean 96/4)", unit: "кг", quantity: 0.50)
//            ],
//        directions: "Лук и морковку притушить  на пару пшиках масла, добавить фарш и немного обжарить на большом огне, добавить /хорошо промытый рис, специи, зелень, добавить половину томатного сока. Начинить перцы. Остальной томатный сок смешиваю с кипятком и заливаю перцы в казане примерно на 3/4. В этот раз готовила в скороварке на режиме low 25 миную.",
//        category: Category(name: "Основные блюда", image: "dish"),
//        isFavorite: false,
//        menuItems: []
//    ),
//    Recipe(
//        name: "Creamy Spinach and Artichoke Soup",
//        image: "soup",
//        ingredients:
//            [Ingredient(name: "extra-firm tofu, drained", unit: "pkg", quantity: 12), Ingredient(name: "lemon juice", unit: "tbs", quantity: 3), Ingredient(name: "white wine vinegar", unit: "tbs", quantity: 1), Ingredient(name: "yellow mustard", unit: "ts", quantity: 0.25)],
//        directions: "Preheat oven to 350°F. Line a 2-quart square baking dish with parchment paper. For filling, in a small saucepan combine figs and 1 cup water. Bring to boiling; reduce heat. Cover and simmer 10 minutes or until figs are soft. Transfer figs and cooking liquid to a blender or food processor. Add lemon juice and vanilla. Cover and blend until smooth.",
//        category: Category(name: "Супы", image: "soup"),
//        isFavorite: true,
//        menuItems: []
//    ),
//    Recipe(
//        name: "Pumkin Pie",
//        image: "dessert",
//        ingredients:
//            [Ingredient(name: "extra-firm tofu, drained", unit: "pkg", quantity: 12), Ingredient(name: "lemon juice", unit: "tbs", quantity: 3), Ingredient(name: "white wine vinegar", unit: "tbs", quantity: 1), Ingredient(name: "yellow mustard", unit: "ts", quantity: 0.25)],
//        directions: "Preheat oven to 350°F. Line a 2-quart square baking dish with parchment paper. For filling, in a small saucepan combine figs and 1 cup water. Bring to boiling; reduce heat. Cover and simmer 10 minutes or until figs are soft. Transfer figs and cooking liquid to a blender or food processor. Add lemon juice and vanilla. Cover and blend until smooth.",
//        category: Category(name: "Десерты", image: "dessert"),
//        isFavorite: false,
//        menuItems: []
//    ),
//    Recipe(
//        name: "Creamy Spinach and Artichoke Soup",
//        image: "garnish1",
//        ingredients:
//            [Ingredient(name: "extra-firm tofu, drained", unit: "pkg", quantity: 12), Ingredient(name: "lemon juice", unit: "tbs", quantity: 3), Ingredient(name: "white wine vinegar", unit: "tbs", quantity: 1), Ingredient(name: "yellow mustard", unit: "ts", quantity: 0.25)],
//        directions: "Preheat oven to 350°F. Line a 2-quart square baking dish with parchment paper. For filling, in a small saucepan combine figs and 1 cup water. Bring to boiling; reduce heat. Cover and simmer 10 minutes or until figs are soft. Transfer figs and cooking liquid to a blender or food processor. Add lemon juice and vanilla. Cover and blend until smooth.",
//        category: Category(name: "Завтраки", image: "breakfast"),
//        isFavorite: true,
//        menuItems: []
//    ),
//    Recipe(
//        name: "Хлеб с семенами",
//        image: "drink1",
//        ingredients:
//            [Ingredient(name: "Минеральная вода", unit: "л", quantity: 1),
//             Ingredient(name: "лайм", unit: "шт", quantity: 2),
//             Ingredient(name: "сахзам", unit: "ст.л", quantity: 3),
//             Ingredient(name: "листья мяты", unit: "шт", quantity: 10)],
//        directions: "Нарезать лайм кружочками. В минеланую воду добавить лайм, сахзам по вкусу, мяты и выдавить сок 2 лаймов. Все перемешать и потреблять добавив лед.",
//        category: Category(name: "ПП Выпечка", image: "baking"),
//        isFavorite: true,
//        menuItems: []
//    )
//]

//for recipe in recipes {
//    container.mainContext.insert(recipe)
//}

