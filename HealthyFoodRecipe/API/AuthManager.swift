//
//  AuthManager.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 7/9/24.
//

import Foundation

enum LogInError: Error {
  case invalidResponse
}

struct LogInRequest: Codable {
  let installation_token: String
}

struct LogInResponse: Codable {
  let token: String
}

class AuthManager {
  
  private let authTokenKey = "AuthToken"
  
  func logIn(installationToken: String) async throws {
    print("logIn")
    let url = URL(string: "http://127.0.0.1:8002/auth/login")!
    
    let requestBody = LogInRequest(installation_token: installationToken)
    let requestData = try JSONEncoder().encode(requestBody)
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let (data, response) = try await URLSession.shared.upload(for: request, from: requestData)
    
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
      throw ActivationError.invalidResponse
    }
    
    let logInResponse = try JSONDecoder().decode(LogInResponse.self, from: data)
    
    saveAuthToken(logInResponse.token)
  }
  
  private func saveAuthToken(_ authToken: String) {
    UserDefaults.standard.set(authToken, forKey: authTokenKey)
  }
  
  func getAuthToken() -> String? {
    return UserDefaults.standard.string(forKey: authTokenKey)
  }

}
