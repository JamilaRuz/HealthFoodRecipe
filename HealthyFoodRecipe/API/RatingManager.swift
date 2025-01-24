import SwiftUI
import StoreKit

class RatingManager: ObservableObject {
    @AppStorage("user_actions_count") private var actionCount = 0
    @AppStorage("last_rating_prompt") private var lastPromptDate: Double = 0
    @AppStorage("has_rated") private var hasRated = false
    
    private let minimumActionsBeforeRating = 3
    private let daysBetweenPrompts = 90
    
    func incrementActionCount() {
        actionCount += 1
    }
    
    func shouldRequestReview() -> Bool {
        let actionCount = UserDefaults.standard.integer(forKey: "user_actions_count")
        let firstLaunchDate = UserDefaults.standard.object(forKey: "first_launch_date") as? Date
        let lastRatingPrompt = UserDefaults.standard.object(forKey: "last_rating_prompt") as? Date
        
        // First time rating (after 30 days)
        if !UserDefaults.standard.bool(forKey: "has_rated") {
            let daysSinceFirstLaunch = firstLaunchDate.map { 
                Calendar.current.dateComponents([.day], from: $0, to: Date()).day ?? 0
            } ?? 0
            return daysSinceFirstLaunch >= 30 && actionCount >= 3
        }
        
        // Subsequent ratings (every 90 days)
        let daysSinceLastPrompt = lastRatingPrompt.map {
            Calendar.current.dateComponents([.day], from: $0, to: Date()).day ?? 0
        } ?? 0
        
        return daysSinceLastPrompt >= 90 && actionCount >= 3
    }
    
    func requestReview() {
        guard shouldRequestReview() else { return }
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: windowScene)
            lastPromptDate = Date().timeIntervalSince1970
        }
    }
}
