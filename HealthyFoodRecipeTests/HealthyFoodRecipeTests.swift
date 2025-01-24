//
//  HealthyFoodRecipeTests.swift
//  HealthyFoodRecipeTests
//
//  Created by Jamila Ruzimetova on 12/19/24.
//

import Testing
import XCTest
@testable import HealthyFoodRecipe

struct HealthyFoodRecipeTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }

}

class RatingManagerTests: XCTestCase {
    var ratingManager: RatingManager!
    let defaults = UserDefaults.standard
    
    override func setUp() {
        super.setUp()
        ratingManager = RatingManager()
        // Clear any existing values
        defaults.removeObject(forKey: "user_actions_count")
        defaults.removeObject(forKey: "has_rated")
        defaults.removeObject(forKey: "last_rating_prompt")
    }
    
    func testInitialState() {
        XCTAssertEqual(defaults.integer(forKey: "user_actions_count"), 0)
        XCTAssertFalse(defaults.bool(forKey: "has_rated"))
    }
    
    func testIncrementActionCount() {
        ratingManager.incrementActionCount()
        XCTAssertEqual(defaults.integer(forKey: "user_actions_count"), 1)
        
        ratingManager.incrementActionCount()
        XCTAssertEqual(defaults.integer(forKey: "user_actions_count"), 2)
    }
    
    func testShouldNotRequestReviewBeforeMinimumActions() {
        // Action count less than minimum required (3)
        ratingManager.incrementActionCount()
        ratingManager.incrementActionCount()
        
        XCTAssertFalse(ratingManager.shouldRequestReview())
    }
    
    func testShouldRequestReviewAfterMinimumActions() {
        // Perform minimum required actions
        for _ in 0..<3 {
            ratingManager.incrementActionCount()
        }
        
        XCTAssertTrue(ratingManager.shouldRequestReview())
    }
    
    func testShouldNotRequestReviewIfAlreadyRated() {
        // Set has_rated to true
        defaults.set(true, forKey: "has_rated")
        
        // Even with enough actions
        for _ in 0..<3 {
            ratingManager.incrementActionCount()
        }
        
        XCTAssertFalse(ratingManager.shouldRequestReview())
    }
    
    func testShouldNotRequestReviewWithinDaysBetweenPrompts() {
        // Set last prompt to recent date
        defaults.set(Date(), forKey: "last_rating_prompt")
        
        // Even with enough actions
        for _ in 0..<3 {
            ratingManager.incrementActionCount()
        }
        
        XCTAssertFalse(ratingManager.shouldRequestReview())
    }
    
    func testShouldRequestReviewAfterDaysBetweenPrompts() {
        // Set last prompt to 91 days ago
        let oldDate = Calendar.current.date(byAdding: .day, value: -91, to: Date())!
        defaults.set(oldDate, forKey: "last_rating_prompt")
        
        // Perform minimum required actions
        for _ in 0..<3 {
            ratingManager.incrementActionCount()
        }
        
        XCTAssertTrue(ratingManager.shouldRequestReview())
    }
}
