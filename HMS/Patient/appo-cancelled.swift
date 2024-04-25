//
//  appointments-cancelled.swift
//  HMS
//
//  Created by Protyush Kundu on 24/04/24.
//

import SwiftUI

struct CancelledAppointment: Identifiable {
    let id = UUID()
    var date: Date
    var doctorName: String
    var doctorType: String
    var bookingID: String
    var doctorImage: Image
}

struct CancelledAppointmentView: View {
    let appointment: CancelledAppointment

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                appointment.doctorImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .padding(.trailing, 8)
                VStack(alignment: .leading, spacing: 4) {
                    Text(appointment.date, style: .date)
                        .font(.headline)
                    Text("Dr. \(appointment.doctorName)")
                        .font(.subheadline)
                    Text(appointment.doctorType)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("Booking ID: \(appointment.bookingID)")
                        .font(.footnote)
                }
            }

            Rectangle()
                .fill(Color.blue)
                .frame(width: 100, height: 50)
                .cornerRadius(8)
                .overlay(
                    Button(action: {
                        // Cancel action
                    }) {
                        HStack {
                            Text("ReBook")
                                .foregroundColor(.white)
                        }
                        .padding()
                    }
                )
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}

/*struct Cancelledview: View {
    let cancelledAppointments: [CancelledAppointment] = [
      /*  CancelledAppointment(date: Date(timeIntervalSinceNow: -86400), doctorName: "Dr. Amanda Johnson", doctorType: "Cardiologist", bookingID: "#XYZ123", doctorImage: Image("doc5")),
        CancelledAppointment(date: Date(timeIntervalSinceNow: -259200), doctorName: "Dr. Michael Brown", doctorType: "Neurologist", bookingID: "#PQRS456", doctorImage: Image("doc6"))*/
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(cancelledAppointments, id: \.id) { appointment in
                    CancelledAppointmentView(appointment: appointment)
                }
            }
            .padding()
        } 
    }
}

struct CancelledView_Previews: PreviewProvider {
    static var previews: some View {
        CancelledView()
    }
}
*/
