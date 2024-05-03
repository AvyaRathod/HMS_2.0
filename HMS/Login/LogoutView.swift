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
        Button(action: logout) {
            Text("Logout")
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.red, lineWidth: 2)
                )
                .padding(.horizontal, 40) // Add padding to increase the button width
        }
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

struct LogoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView()
    }
}
