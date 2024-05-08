//  profile-patient.swift
//  HMS
//
//  Created by Protyush Kundu on 02/05/24.
//

import SwiftUI
import Firebase

struct PatientProfileView: View {
    @State private var isEditingProfile = false
    @State private var isViewingRecords = false
    @State private var showAlert = false
    @EnvironmentObject var userTypeManager: UserTypeManager

    @State private var patient = PatientModel()

    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(spacing: 20) {
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.blue)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                if let name = patient.name {
                                    Text(name)
                                        .font(.title)
                                        .fontWeight(.bold)
                                }
                                if let id = patient.id {
                                    Text("Patient ID: \(id)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                if let gender = patient.gender {
                                    Text("Gender: \(gender.rawValue)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                if let email = patient.email {
                                    Text("Email: \(email)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                if let address = patient.address {
                                    Text("Address: \(address)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                if let phoneNumber = patient.contact {
                                    Text("Phone: \(phoneNumber)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
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
                    .padding(.bottom, 50)
                }
                
                // Logout Button
                LogoutView()
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Logout"), message: Text("Are you sure you want to logout?"), primaryButton: .default(Text("Yes")) {
                    logout()
                }, secondaryButton: .cancel())
            }
            .onAppear{if !userTypeManager.userID.isEmpty {
                fetchPatientData()
            }
            }
        }
    }
    
    func fetchPatientData() {
            let db = Firestore.firestore()
        db.collection("Patients").document(userTypeManager.userID).getDocument { document, error in
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data: \(dataDescription)")
                    self.patient = PatientModel(dictionary: document.data() ?? [:], id: document.documentID)!
                } else {
                    print("Document does not exist")
                }
            }
        }
    
    func logout() {
        print("Logging out...")
    }
}

//struct PatientProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        let patient = PatientModel(name: "John Doe", id: "123456", age: 35, gender: "Male", email: "johndoe@example.com", address: "123 Main St, Anytown", phoneNumber: "555-1234")
//        return PatientProfileView(patient: patient)
//    }
//}
