//
//  appointments-completed.swift
//  HMS
//
//  Created by Protyush Kundu on 24/04/24.
//

import SwiftUI

struct CompletedAppointmentView: View {
    let appointment: AppointmentModel
    @State private var prescription: PrescriptionModel?

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Dr. \(appointment.doctorName ?? "")")
                        .font(.subheadline)
                    Text(appointment.doctorSpecialisation ?? "")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("Appointment Date: \(appointment.formattedDate)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .padding()

            if let prescription = prescription {
                NavigationLink(destination: EmptyView()) {
                    Text("View My Prescription")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
        }
        .onAppear {
            PrescriptionManager.shared.fetchPrescription(patientId: appointment.patientID) { fetchedPrescription in
                self.prescription = fetchedPrescription
            }
        }
    }
}

