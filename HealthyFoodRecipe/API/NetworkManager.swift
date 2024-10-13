//
//  NetworkManager.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 9/14/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func authenticatedRequest(_ url: String, method: String = "GET", body: Data? = nil, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = method
        
        if let token = AuthManager.shared.getAuthToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = body {
            request.httpBody = body
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        URLSession.shared.dataTask(with: request, completionHandler: completion).resume()
    }
}
