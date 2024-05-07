//
//  appointments-completed.swift
//  HMS
//
//  Created by Protyush Kundu on 24/04/24.
//

import SwiftUI
import Firebase


struct CompletedAppointmentView: View {
    var appointment: AppointmentModel
    @Binding var appointments: [AppointmentModel]
    @State private var doctorName: String = "Loading..."
    @State private var specialisation: String = "Loading..."
    
    var body: some View {
        ZStack{
            HStack{
                
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 100, height: 130)
                    .cornerRadius(30)
                    .padding(.leading, 60)
                    .overlay(
                        Image("DrPriyaPhoto") // Use the actual image here
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                    )
                VStack(alignment: .leading) {
                    Text(doctorName)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Text(specialisation)
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    Text("Date: \(appointment.formattedDate)")
                        .font(.subheadline)
                    Text("Time: \(appointment.timeSlot)")
                        .font(.subheadline)
                    Button(action: {
//                        cancelAppointment()
                    }) {
                        Text("View Prescription")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(Color.customBlue)
                            .cornerRadius(8)
                    }
                }
            }
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 4)
                .padding(.bottom)
                .padding(.leading)
                .padding(.trailing)
            }
        .onAppear {
            fetchDoctorDetails()
        }

        }
    
    private func fetchDoctorDetails() {
        let db = Firestore.firestore()
        let doctorsRef = db.collection("doctors")
        
        doctorsRef.whereField("DocID", isEqualTo: appointment.doctorID).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching doctor details: \(error.localizedDescription)")
                self.doctorName = "Doctor details could not be loaded."
                self.specialisation = "Please try again later."
            } else if let querySnapshot = querySnapshot, !querySnapshot.isEmpty {
                guard let data = querySnapshot.documents.first?.data() else {
                    self.doctorName = "Doctor not found."
                    self.specialisation = "Specialisation unknown."
                    return
                }
                
                self.doctorName = data["name"] as? String ?? "No name available"
                self.specialisation = data["specialisation"] as? String ?? "No specialisation available"
            } else {
                print("No matching document found for DocID \(self.appointment.doctorID)")
                self.doctorName = "Doctor not found."
                self.specialisation = "Specialisation unknown."
            }
        }
    }
}
//    .onAppear {
//        PrescriptionManager.shared.fetchPrescription(patientId: appointment.patientID) { fetchedPrescription in
//            self.prescription = fetchedPrescription
//        }
//    }
