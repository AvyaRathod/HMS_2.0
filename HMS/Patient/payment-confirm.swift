//
//  payment-confirm.swift
//  HMS
//
//  Created by Protyush Kundu on 29/04/24.
//


import SwiftUI

struct PaymentSuccessfulView: View {
    var appointmentDetails: AppointmentDetails
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
                .foregroundColor(.green)
            
            Text("Payment Successful")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text("Thank you for your payment.")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Appointment Details")
                    .font(.title2)
                    .fontWeight(.bold)
                
                HStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(.blue)
                    Text(appointmentDetails.doctor)
                        .font(.subheadline)
                }
                
                HStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(.blue)
                    Text(appointmentDetails.patient)
                        .font(.subheadline)
                }
                
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.blue)
                    Text(appointmentDetails.date)
                        .font(.subheadline)
                }
                
                HStack {
                    Image(systemName: "clock")
                        .foregroundColor(.blue)
                    Text(appointmentDetails.time)
                        .font(.subheadline)
                }
            }
            
            Spacer()
            
            Button(action: {
                // Add action for "Go to Home" button here
            }) {
                Text("Go to Home")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
            }
        }
        .padding()
        .navigationBarHidden(true) // Hide navigation bar if it's part of a navigation stack
    }
}

struct AppointmentDetails {
    var doctor: String
    var patient: String
    var date: String
    var time: String
}

struct PaymentSuccessfulView_Previews: PreviewProvider {
    static var previews: some View {
        let appointment = AppointmentDetails(doctor: "Dr. Kenny Adeola", patient: "Madilyn Doe", date: "19 Nov, 2023", time: "8:30 AM")
        return PaymentSuccessfulView(appointmentDetails: appointment)
    }
}
