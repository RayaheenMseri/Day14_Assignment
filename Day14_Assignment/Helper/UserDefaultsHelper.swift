//
//  UserDefaultsHelper.swift
//  Day14_Assignment
//
//  Created by Rayaheen Mseri on 23/09/1446 AH.
//

import SwiftUI

// Helper class to handle saving, retrieving, and removing a token in UserDefaults
class NewsDefaultsHelper{
    static let shared = NewsDefaultsHelper() // Singleton instance of the helper class
    
    // Save the token to UserDefaults
    func saveToken(token: String){
        UserDefaults.standard.set(token, forKey: "mytoken") // Saves token with a unique key "mytoken"
    }
    
    // Retrieve the token from UserDefaults
    func getToken() -> String? {
        UserDefaults.standard.string(forKey: "mytoken") // Returns the token if it exists, else returns nil
    }
    
    // Remove the token from UserDefaults
    func removeToken(){
        UserDefaults.standard.removeObject(forKey: "mytoken") // Removes the token using the same key "mytoken"
    }
}

