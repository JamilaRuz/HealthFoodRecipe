//
//  AuthManager.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 7/9/24.
//

import Foundation

class AuthManager {
    static let shared = AuthManager()
    private init() {}
    
    private var authToken: String?
    private let authTokenKey = "AuthToken"
    
    func getAuthToken() -> String? {
        if authToken == nil {
            authToken = UserDefaults.standard.string(forKey: authTokenKey)
        }
        return authToken
    }
    
    func setAuthToken(_ token: String) {
        authToken = token
        UserDefaults.standard.set(token, forKey: authTokenKey)
    }
    
    func clearAuthToken() {
        authToken = nil
        UserDefaults.standard.removeObject(forKey: authTokenKey)
    }
}
