//
//  APIManager.swift
//  Day14_Assignment
//
//  Created by Rayaheen Mseri on 23/09/1446 AH.
//

import SwiftUI

class APIKeyManager {
    static let shared = APIKeyManager() // Singleton instance for global access
    
    // Method to retrieve the API key from secure storage
    func getAPIKey() -> String {
        // Attempt to retrieve the API key from the Keychain
        if let keyChainKey = SecureStorage.shared.getApiKeyFromKeyChain() {
            return keyChainKey
        }
        // Return a default message if no API key is found
        return "No_API_Key_Found"
    }
}
