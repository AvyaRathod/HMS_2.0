//
//  PrescriptionView.swift
//  HMS
//
//  Created by Shashwat Singh on 30/04/24.
//

import SwiftUI
import FirebaseFirestore
import Firebase

struct PrescriptionView: View {
    
    @State private var prescriptionData: PrescriptionModel?
    var appointment: AppointmentModel
    @StateObject private var viewModel = PrescriptionViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Description:")
                            .font(.headline)
                        
                        if let description = prescriptionData?.description {
                            Text(description)
                                .font(.body)
                        } else {
                            Text("Description not available")
                                .font(.body)
                        }
                        
                        Divider()
                        
                        Text("Prescribed Medicine:")
                            .font(.headline)
                        ForEach(prescriptionData?.prescribedMedicines.keys.sorted() ?? [], id: \.self) { medicineName in
                            if let dosage = prescriptionData?.prescribedMedicines[medicineName]?.dosage {
                                Text("\(medicineName): \(dosage)")
                            }
                        }
                        
                        Divider()
                        
                        Text("Prescribed Tests:")
                            .font(.headline)
                        ForEach(prescriptionData?.prescribedTest ?? [], id: \.self) { test in
                            Text(test)
                        }
                        
                        Divider()
                        
                        Text("Prescribed Treatment:")
                            .font(.headline)
                        if let prescription = prescriptionData?.prescription {
                            Text(prescription)
                                .font(.body)
                        } else {
                            Text("Prescription not available")
                                .font(.body)
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .navigationBarTitle("Prescription", displayMode: .automatic)
                }
            }
        }
//        .onAppear {
//            fetchPrescriptionData()
//        }
        .onAppear {
            Task{
                
            }
            
        }
    }
    
    private func fetchPrescriptionData() {
        let db = Firestore.firestore()
        let prescriptionsRef = db.collection("prescriptions")
        
        prescriptionsRef.whereField("appointmentID", isEqualTo: appointment.id).getDocuments { querySnapshot, error in
            if let error = error {
                print("Error fetching prescription data: \(error.localizedDescription)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No prescription data found for appointmentID: \(appointment.id)")
                return
            }
            
            if let firstDocument = documents.first {
                do {
                    let prescriptionData = try firstDocument.data(as: PrescriptionModel.self)
                    self.prescriptionData = prescriptionData
                } catch {
                    print("Error decoding prescription data: \(error.localizedDescription)")
                }
            } else {
                print("No prescription data found for appointmentID: \(appointment.id)")
            }
        }
    }
}

//struct PrescriptionView_Previews: PreviewProvider {
//    static var previews: some View {
//        PrescriptionView(appointmentID: "your_appointment_id")
//    }
//}

