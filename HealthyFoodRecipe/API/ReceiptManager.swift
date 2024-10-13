//
//  ReceiptManager.swift
//  HealthyFoodRecipe
//
//  Created by Jamila Ruzimetova on 9/14/24.
//

import Foundation
import StoreKit

class ReceiptManager {
    static let shared = ReceiptManager()
    private init() {}

    func fetchReceiptData(completion: @escaping (Data?) -> Void) {
        #if targetEnvironment(simulator)
            print("Running in Simulator - using stub receipt data")
            let stubReceiptData = self.createStubReceiptData()
            completion(stubReceiptData)
        #else
            guard let receiptURL = Bundle.main.appStoreReceiptURL else {
                completion(nil)
                return
            }

            if FileManager.default.fileExists(atPath: receiptURL.path) {
                completion(try? Data(contentsOf: receiptURL))
            } else {
                refreshReceipt { success in
                    if success, let data = try? Data(contentsOf: receiptURL) {
                        completion(data)
                    } else {
                        completion(nil)
                    }
                }
            }
        #endif
    }

    private func refreshReceipt(completion: @escaping (Bool) -> Void) {
        #if targetEnvironment(simulator)
            print("Running in Simulator - skipping receipt refresh")
            completion(true) // Simulate successful refresh in Simulator
        #else
            let request = SKReceiptRefreshRequest()
            request.delegate = ReceiptRequestDelegate(completion: completion)
            request.start()
        #endif
    }

    func sendReceiptToServer(receiptData: Data, completion: @escaping (Bool) -> Void) {
        let base64Receipt: String
        let url: URL
        #if targetEnvironment(simulator)
            print("Running in Simulator - sending stub receipt to server")
            url = URL(string: ApiConf.verifySimulatorReceiptUrl)!
            base64Receipt = receiptData.base64EncodedString()
        #else
            url = URL(string: ApiConf.verifyAppStoreReceiptUrl)!
            base64Receipt = receiptData.base64EncodedString()
        #endif

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = ["receipt_data": base64Receipt]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        print("Sending receipt to server... \(base64Receipt)")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error sending receipt: \(error)")
                completion(false)
                return
            }
            
            guard let data = data else {
                print("No data received from server")
                completion(false)
                return
            }
            
            do {
                print("Receipt verification response: \(String(data: data, encoding: .utf8)!)")
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let authToken = json["auth_token"] as? String {
                    AuthManager.shared.setAuthToken(authToken)
                    print("Auth token received and stored")
                    completion(true)
                } else {
                    print("Invalid response format or missing auth token")
                    completion(false)
                }
            } catch {
                print("Error parsing server response: \(error)")
                completion(false)
            }
        }.resume()
    }

    private func createStubReceiptData() -> Data {
        // Create a dictionary representing a stub receipt
        let stubReceipt: [String: Any] = [
            "bundle_id": "com.yourcompany.HealthyFoodRecipe",
            "application_version": "1.0",
            "original_purchase_date": "2023-01-01 12:00:00 Etc/GMT",
            "in_app": [
                [
                    "quantity": "1",
                    "product_id": "com.yourcompany.HealthyFoodRecipe.premium",
                    "transaction_id": "1000000000000000",
                    "original_transaction_id": "1000000000000000",
                    "purchase_date": "2023-01-01 12:00:00 Etc/GMT",
                    "original_purchase_date": "2023-01-01 12:00:00 Etc/GMT",
                    "expires_date": "2024-01-01 12:00:00 Etc/GMT"
                ]
            ]
        ]

        // Convert the dictionary to JSON Data
        return try! JSONSerialization.data(withJSONObject: stubReceipt, options: .prettyPrinted)
    }
}

class ReceiptRequestDelegate: NSObject, SKRequestDelegate {
    let completion: (Bool) -> Void

    init(completion: @escaping (Bool) -> Void) {
        self.completion = completion
    }

    func requestDidFinish(_ request: SKRequest) {
        completion(true)
    }

    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Failed to refresh receipt: \(error)")
        completion(false)
    }
}
