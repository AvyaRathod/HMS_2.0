///  Admin.swift profile
//  HMS
//
//  Created by Protyush Kundu on 02/05/24.

import SwiftUI

struct AdminDetails {
    var name: String
    var email: String
    var contact: String
    // Add more properties if needed
}

struct AdminProfile: View {
   
    @State private var showAlert = false
    
    let admin: AdminDetails
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 20) {
                    HStack {
                        // Profile Image
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.blue)
                        
                        // Admin Details
                        VStack(alignment: .leading, spacing: 8) {
                            Text(admin.name)
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Email: \(admin.email)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("Phone: \(admin.contact)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.leading, 20)
                        
                        Spacer()
                    }
                    .padding(.top, 30)
                    .padding(.horizontal, 20)
                    
                    // Buttons
             
                    .padding(.horizontal, 20)
                    
                    Spacer()
                }
                .padding(.bottom, 50) // Add padding at the bottom for the logout button
            }
            
            // Logout Button
            LogoutView()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Logout"), message: Text("Are you sure you want to logout?"), primaryButton: .default(Text("Yes")) {
                logout()
            }, secondaryButton: .cancel())
        }
    }
    
    func logout() {
        // Perform logout action here
        // For demonstration purposes, I'm just printing a message
        print("Logging out...")
        
        // Redirect to login screen
        // You should replace this with your actual navigation logic
    }
}

struct AdminProfile_Previews: PreviewProvider {
    static var previews: some View {
        let admin = AdminDetails(name: "Admin", email: "admin@admin.com", contact: "123-456-7890")
        return AdminProfile(admin: admin)
    }
}
