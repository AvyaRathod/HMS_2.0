//
//  AppointmentsView.swift
//  HMS
//
//  Created by Protyush Kundu on 24/04/24.
//

import SwiftUI

struct AppointmentsView: View {
    @State private var selectedTab: Tab = .upcoming

    enum Tab {
        case upcoming
        case completed
        case cancelled
    }

    let bookings: [DoctorBooking] = [
        DoctorBooking(date: Date(timeIntervalSinceNow: 0), doctorName: "Kenny Adeola", doctorType: "General practitioner", bookingID: "#12345A67B", doctorImage: Image("doc1")),
        DoctorBooking(date: Date(timeIntervalSinceNow: -500000), doctorName: "Taiwo Abdulsalaam", doctorType: "General practitioner", bookingID: "#48345e27C", doctorImage: Image("doc2")),
        DoctorBooking(date: Date(timeIntervalSinceNow: 604800), doctorName: "Jane Smith", doctorType: "Dermatologist", bookingID: "#78910D11E", doctorImage: Image("doc3"))
    ]

    var completedDoctors: [CompletedDoctor] {
        // Prepare completed doctor appointments based on bookings
        return bookings.filter { $0.date < Date() }
            .map { CompletedDoctor(doctorName: $0.doctorName, doctorType: $0.doctorType, doctorImage: $0.doctorImage) }
    }

    var cancelledDoctors: [CancelledDoctor] {
        // Prepare cancelled doctor appointments based on bookings
        // For demonstration, let's consider some hardcoded cancelled doctors
        return [
            CancelledDoctor(doctorName: "Dr. Sarah Johnson", doctorType: "Ophthalmologist", doctorImage: Image("doc4")),
            CancelledDoctor(doctorName: "Dr. Michael Brown", doctorType: "Neurologist", doctorImage: Image("doc5"))
        ]
    }

    var body: some View {
        VStack {
            // All Appointments Text Section
            Text("All Appointments")
                .font(.title)
                .padding(.top, 20) // Add padding to the top of the text

            // Tab Selection Buttons
            HStack {
                // Upcoming Appointments Button
                Button(action: {
                    selectedTab = .upcoming
                }) {
                    Text("Upcoming")
                        .padding()
                        .foregroundColor(selectedTab == .upcoming ? .blue : .black)
                }
                .background(selectedTab == .upcoming ? Color.blue.opacity(0.2) : Color.clear)
                .cornerRadius(10)

                // Completed Appointments Button
                Button(action: {
                    selectedTab = .completed
                }) {
                    Text("Completed")
                        .padding()
                        .foregroundColor(selectedTab == .completed ? .blue : .black)
                }
                .background(selectedTab == .completed ? Color.blue.opacity(0.2) : Color.clear)
                .cornerRadius(10)

                // Cancelled Appointments Button
                Button(action: {
                    selectedTab = .cancelled
                }) {
                    Text("Cancelled")
                        .padding()
                        .foregroundColor(selectedTab == .cancelled ? .blue : .black)
                }
                .background(selectedTab == .cancelled ? Color.blue.opacity(0.2) : Color.clear)
                .cornerRadius(10)
            }
            .padding()

            // Display Content Based on Selected Tab
            switch selectedTab {
            case .upcoming:
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(bookings, id: \.id) { booking in
                            BookingView(booking: booking)
                        }
                    }
                    .padding()
                }
            case .completed:
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(completedDoctors, id: \.id) { doctor in
                            CompletedDoctorView(doctor: doctor)
                        }
                    }
                    .padding()
                }
            case .cancelled:
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(cancelledDoctors, id: \.id) { doctor in
                            CancelledDoctorView(doctor: doctor)
                        }
                    }
                    .padding()
                }
            }

            Spacer()
        }
        .navigationTitle("Appointments")
    }
}

struct AppointmentsView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentsView()
    }
}


struct CompletedDoctor: Identifiable {
    let id = UUID()
    var doctorName: String
    var doctorType: String
    var doctorImage: Image
}

struct CompletedDoctorView: View {
    let doctor: CompletedDoctor

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                doctor.doctorImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .padding(.trailing, 8)
                VStack(alignment: .leading, spacing: 4) {
                    Text("Dr. \(doctor.doctorName)")
                        .font(.subheadline)
                    Text(doctor.doctorType)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
          
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}

struct CancelledDoctor: Identifiable {
    let id = UUID()
    var doctorName: String
    var doctorType: String
    var doctorImage: Image
}

struct CancelledDoctorView: View {
    let doctor: CancelledDoctor

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                doctor.doctorImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .padding(.trailing, 8)
                VStack(alignment: .leading, spacing: 4) {
                    Text("Dr. \(doctor.doctorName)")
                        .font(.subheadline)
                    Text(doctor.doctorType)
                        .font(.subheadline)
                        .foregroundColor(.gray)
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
                        Text("Rebook")
                            .foregroundColor(.white)
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
