//
//  Day14_AssignmentApp.swift
//  Day14_Assignment
//
//  Created by Rayaheen Mseri on 23/09/1446 AH.
//

import SwiftUI

@main
struct Day14_AssignmentApp: App {
    @StateObject private var darkModeManager = DarkModeManager()
    
    // App initializer
    init (){
        let apiKey = "42bcbf162bb04adba36eaf161e0013be"  // Define the API key
        SecureStorage.shared.saveToKeyChain(apiKey: apiKey)  // Securely store the API key in Keychain
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(darkModeManager)
        }
    }
}
