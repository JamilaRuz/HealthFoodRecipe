//
//  ApiConf.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 7/11/24.
//

import Foundation

class ApiConf {
   static let baseUrl = "http://127.0.0.1:8001/" // for local testing
    // static let baseUrl = "https://dileknutrition-recipes-test-1-33cf34cff1cf.herokuapp.com/"

    static let verifyAppStoreReceiptUrl = baseUrl + "auth/verify-app-store-receipt"
    static let verifySimulatorReceiptUrl = baseUrl + "auth/verify-simulator-receipt"
    static let recipesUrl = baseUrl + "recipes"
    static let lastChangeUrl = baseUrl + "last-change"
}
