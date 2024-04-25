//
//  appointments-upcoming.swift
//  HMS
//
//  Created by Protyush Kundu on 24/04/24.
//

import SwiftUI

struct DoctorBooking: Identifiable {
    let id = UUID()
    var date: Date
    var doctorName: String
    var doctorType: String
    var bookingID: String
    var doctorImage: Image
}

struct BookingView: View {
    let booking: DoctorBooking

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                booking.doctorImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .padding(.trailing,8)
                VStack(alignment: .leading, spacing: 4) {
                    Text(booking.date, style: .date)
                        .font(.headline)
                    Text("Dr. \(booking.doctorName)")
                        .font(.subheadline)
                    Text(booking.doctorType)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("Booking ID: \(booking.bookingID)")
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
                          //  Image(systemName: "xmark")
                            Text("Cancel")
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


