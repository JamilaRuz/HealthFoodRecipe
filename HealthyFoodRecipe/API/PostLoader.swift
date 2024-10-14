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
    let ingredients: String
    let instructions: String
}

struct PostCategory: Decodable {
    let id: Int
    let name: String
}

struct PostLoader {
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func loadPosts(isFirstAttempt: Bool = true) async throws -> [Post] {
        return try await withCheckedThrowingContinuation { continuation in
            networkManager.authenticatedRequest(ApiConf.recipesUrl) { data, response, error in
                if let error = error {
                    print("Failed to load posts: \(error)")
                    continuation.resume(throwing: error)
                    return
                }
                
                guard let data = data else {
                    continuation.resume(throwing: NSError(domain: "PostLoader", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                    return
                }
                
                do {
                    let posts = try JSONDecoder().decode([Post].self, from: data)
                    continuation.resume(returning: posts)
                } catch {
                    print("Failed to decode posts: \(error)")
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func getLastChangeTimeFromServer() async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            networkManager.authenticatedRequest(ApiConf.lastChangeUrl) { data, response, error in
                if let error = error {
                    print("Failed to get last change time: \(error)")
                    continuation.resume(throwing: error)
                    return
                }
                
                guard let data = data else {
                    continuation.resume(throwing: NSError(domain: "PostLoader", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                    return
                }
                
                do {
                    let lastChangeTime = try JSONDecoder().decode(String.self, from: data)
                    continuation.resume(returning: lastChangeTime)
                    print("Last change time from server: \(lastChangeTime)")
                } catch {
                    print("Failed to decode last change time: \(error)")
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
