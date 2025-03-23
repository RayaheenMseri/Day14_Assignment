//
//  SecureStorage.swift
//  Day14_Assignment
//
//  Created by Rayaheen Mseri on 23/09/1446 AH.
//
import Foundation

class SecureStorage {
    static let shared = SecureStorage() // Singleton instance for global access

    // Method to save API key securely in Keychain
    func saveToKeyChain(apiKey: String, service: String = "NewsAPIKey") {
        let data = apiKey.data(using: .utf8) // Convert API key to Data format
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword, // Store as a generic password
            kSecAttrService as String: service, // Specify the service name for identification
            kSecValueData as String: data! // Store the actual API key data
        ]
        
        SecItemDelete(query as CFDictionary) // Delete any existing item with the same key
        SecItemAdd(query as CFDictionary, nil) // Add new key to Keychain
    }

    // Method to retrieve the API key from Keychain
    func getApiKeyFromKeyChain(service: String = "NewsAPIKey") -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword, // Look for a generic password
            kSecAttrService as String: service, // Identify by service name
            kSecMatchLimit as String: kSecMatchLimitOne, // Return only one match
            kSecReturnData as String: true // Return the stored data
        ]
        
        var dataTypeRef: AnyObject?
        
        // Try to retrieve the stored API key
        if SecItemCopyMatching(query as CFDictionary, &dataTypeRef) == noErr,
           let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8) // Convert back to String
        }
        
        return nil // Return nil if no key is found
    }
}
