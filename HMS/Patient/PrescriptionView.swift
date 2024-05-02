//
//  PrescriptionView.swift
//  HMS
//
//  Created by Shashwat Singh on 30/04/24.
//

import SwiftUI

struct PrescriptionView: View {
    let prescription: Prescription
    

    var body: some View {
        NavigationView{
            Form{
                ScrollView{
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Description:")
                            .font(.headline)
                        Text(prescription.description)
                            .font(.body)
                        
                        
                        Divider()
                        
                        Text("Prescribed Medicine:")
                            .font(.headline)
                        Text(prescription.prescribedMedicine)
                        
                        
                        
                        Divider()
                        
                        Text("Prescribed Tests:")
                            .font(.headline)
                        Text(prescription.prescribedTests)
                            .font(.body)
                        
                        Divider()
                        
                        Text("Prescribed Treatment:")
                            .font(.headline)
                        Text(prescription.prescribedTreatment)
                            .font(.body)
                        Spacer()
                    }
                    .padding()
                    .navigationBarTitle("Prescription", displayMode: .automatic)
                }
            }
        }
    }
}

struct Prescription {
    let description: String
    let prescribedMedicine: String
    let prescribedTests: String
    let prescribedTreatment: String
}

struct PrescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        let prescription1 = Prescription(description: "Sick", prescribedMedicine: "Dolo 650", prescribedTests: "Operation", prescribedTreatment: "Rest")
        return PrescriptionView(prescription: prescription1)
    }
}
