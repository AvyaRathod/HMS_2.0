//  profile-patient.swift
//  HMS
//
//  Created by Protyush Kundu on 02/05/24.
//

import SwiftUI

struct PatientDetails {
    var name: String
    var id: String
    var age: Int
    var gender: String
    var email: String
    var address: String
    var phoneNumber: String
}

struct PatientProfileView: View {
    @State private var isEditingProfile = false
    @State private var isViewingRecords = false
    @State private var showAlert = false
    
    let patient: PatientDetails
    
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
                        
                        // Patient Details
                        VStack(alignment: .leading, spacing: 8) {
                            Text(patient.name)
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Patient ID: \(patient.id)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("Age: \(patient.age)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("Gender: \(patient.gender)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("Email: \(patient.email)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("Address: \(patient.address)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("Phone: \(patient.phoneNumber)")
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

struct PatientProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let patient = PatientDetails(name: "John Doe", id: "123456", age: 35, gender: "Male", email: "johndoe@example.com", address: "123 Main St, Anytown", phoneNumber: "555-1234")
        return PatientProfileView(patient: patient)
    }
}
