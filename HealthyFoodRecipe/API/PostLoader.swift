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
  let pictures: [String]
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
  
  let activationManager = ActivationManager()
  let authManager = AuthManager()
  
  let recipesUrl = ApiConf.baseUrl + "recipes"
  let lastChangeUrl = ApiConf.baseUrl + "last-change"
  
  func loadPosts(isFirstAttempt: Bool = true) async throws -> [Post] {
//    print("loadPosts authToken \(authManager.getAuthToken() != nil)")
    
    let url = URL(string: recipesUrl)!
    
    if let authToken = authManager.getAuthToken() {
      var request = URLRequest(url: url)
      request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")

      let (data, response) = try await URLSession.shared.data(for: request)

      let httpResponse = response as! HTTPURLResponse
      if httpResponse.statusCode == 401 {
        if isFirstAttempt {
//          print("Server answered that authToken is expired. Trying to re-login...")
          try await authManager.logIn(installationToken: activationManager.getInstallationToken())
          return try await loadPosts(isFirstAttempt: false)
        } else {
          print("Failed to load data even after re-login attempt!")
          return []
        }
      } else if httpResponse.statusCode != 200 {
        print("Failed to load data. Server responded with code \(httpResponse.statusCode).")
        return []
      }

      return try JSONDecoder().decode([Post].self, from: data)
    } else {
      let (data, response) = try await URLSession.shared.data(from: url)

      let httpResponse = response as! HTTPURLResponse
      if httpResponse.statusCode != 200 {
        print("Failed to load data. Server responded with code \(httpResponse.statusCode).")
        return []
      }

      return try JSONDecoder().decode([Post].self, from: data)
    }
  }
  
  func getLastChangeTimeFromServer() async throws -> String {
    let url = URL(string: lastChangeUrl)!
    let (data, response) = try await URLSession.shared.data(from: url)
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { return "" }
    let lastChangeTimestamp = try JSONDecoder().decode(String.self, from: data)
    
    return lastChangeTimestamp
  }
}
