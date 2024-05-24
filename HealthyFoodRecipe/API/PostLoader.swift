//
//  PostLoader.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 4/17/24.
//

import Foundation

struct Post: Decodable {
  let id: Int
  let name: String
  let pictures: [Int]
  let category: PostCategory
  let ingredients: [PostIngredientWithQuantity]
  let instructions: String
}

struct PostCategory: Decodable {
  let id: Int
  let name: String
}

struct PostIngredientWithQuantity: Decodable {
  let ingredient: PostIngredient
  var unit: String
  var qty: Float
}

struct PostIngredient: Decodable {
  let id: Int
  var name: String
}

struct PostLoader {
  func loadPosts() async throws -> [Post] {
    //        making request
    guard let url = URL(string: "http://127.0.0.1:8001/recipes") else { return []}
    //        perform request with async function
    let (data, response) = try await URLSession.shared.data(from: url)
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { return [] }
    //        trying to decode the data
    let posts = try JSONDecoder().decode([Post].self, from: data)
    
    return posts
  }
}
