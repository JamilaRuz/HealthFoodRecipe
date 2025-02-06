import Foundation

class ApiConf {
    // static let baseUrl = "http://10.0.0.192:8001/" // for local testing from real device
    // static let baseUrl = "http://127.0.0.1:8001/" // for local testing from simulator
    static let baseUrl = "https://recipes.dileknutrition.com/"

    static let verifyAppStoreReceiptUrl = baseUrl + "auth/verify-app-store-receipt"
    static let verifySimulatorReceiptUrl = baseUrl + "auth/verify-simulator-receipt"
    static let recipesUrl = baseUrl + "recipes"
    static let lastChangeUrl = baseUrl + "last-change"
    static let registerPushDeviceTokenUrl = baseUrl + "push-notification/register/apple"
}
