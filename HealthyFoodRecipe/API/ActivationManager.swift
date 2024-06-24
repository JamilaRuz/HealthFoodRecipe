//
//  ActivationManager.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 5/31/24.
//

import Foundation

enum ActivationError: Error {
  case invalidResponse
}

struct CreateTokenRequest: Codable {
  let activation_code: String
}

struct CreateTokenResponse: Codable {
  let installation_token: String
}

class ActivationManager {
  
  private let installationTokenKey = "InstallationToken"
  
  func activateApp() async throws -> String {
    print("createActivationCode")
    let url = URL(string: "http://127.0.0.1:8002/app-activation/create-code")!

    var request = URLRequest(url: url)
    request.httpMethod = "POST"

    let (data, response) = try await URLSession.shared.upload(for: request, from: Data())
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
      throw ActivationError.invalidResponse
    }
    
    let activationCode = try JSONDecoder().decode(String.self, from: data)
    return activationCode
  }
  
  func activateApp(activationCode: String) async throws {
    print("activateApp")
    let url = URL(string: "http://127.0.0.1:8002/auth/activate-app")!
    
    let requestBody = CreateTokenRequest(activation_code: activationCode)
    let requestData = try JSONEncoder().encode(requestBody)
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let (data, response) = try await URLSession.shared.upload(for: request, from: requestData)
    
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
      throw ActivationError.invalidResponse
    }
    
    let createTokenResponse = try JSONDecoder().decode(CreateTokenResponse.self, from: data)
    
    saveInstallationToken(createTokenResponse.installation_token)
  }
  
  func saveInstallationToken(_ installationToken: String) {
    UserDefaults.standard.set(installationToken, forKey: installationTokenKey)
  }
  
  func getInstallationToken() -> String {
    return UserDefaults.standard.string(forKey: installationTokenKey) ?? ""
  }

}
