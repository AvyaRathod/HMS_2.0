//
//  LogoutView.swift
//  HMS
//
//  Created by Avya Rathod on 02/05/24.
//

import SwiftUI
import Firebase

struct LogoutView: View {
    @EnvironmentObject var userTypeManager: UserTypeManager
    
    var body: some View {
        Button("Logout", action: logout)
    }

    func logout() {
        do {
            try Auth.auth().signOut() // Sign out from Firebase authentication
            
            // Reset user defaults
            UserDefaults.standard.removeObject(forKey: "userType")
            UserDefaults.standard.removeObject(forKey: "userID")
            
            // Reset environment objects
            userTypeManager.userType = .unknown
            userTypeManager.userID = ""
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}


#Preview {
    LogoutView()
}
