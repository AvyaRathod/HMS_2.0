
//  profile-doctor.swift
//  HMS
//
//  Created by Protyush Kundu on 02/05/24.
//
//  profile-doctor.swift
//  HMS
//
//  Created by Protyush Kundu on 02/05/24.
//

import SwiftUI

struct DoctorDetails {
    var name: String
    var specialisation: String
    var employeeID: String
    var email: String
    var contact: String
    // Add more properties if needed
}

struct DoctorProfile: View {
    @State private var isEditingProfile = false
    @State private var isViewingRecords = false
    @State private var showAlert = false
    
    let doctor: DoctorDetails
    
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
                        
                        // Doctor Details
                        VStack(alignment: .leading, spacing: 8) {
                            Text(doctor.name)
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Specialisation: \(doctor.specialisation)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("Employee ID: \(doctor.employeeID)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("Email: \(doctor.email)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("Phone: \(doctor.contact)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.leading, 20)
                        
                        Spacer()
                    }
                    .padding(.top, 30)
                    .padding(.horizontal, 20)
                    
                    // Buttons
                    VStack(spacing: 20) {
                        Button(action: {
                            isEditingProfile.toggle()
                        }) {
                            Text("Edit Profile")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue.opacity(0.7))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            isViewingRecords.toggle()
                        }) {
                            Text("View Records")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue.opacity(0.7))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
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

struct DoctorProfile_Previews: PreviewProvider {
    static var previews: some View {
        let doctor = DoctorDetails(name: "Dr. John Smith", specialisation: "Cardiologist", employeeID: "DOC123", email: "johnsmith@example.com", contact: "555-1234")
        return DoctorProfile(doctor: doctor)
    }
}
