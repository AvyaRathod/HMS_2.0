//
//  HomeView.swift
//  HomeView
//
//  Created by shashwat singh   on 16/03/24.
//

import SwiftUI
import Firebase

struct PatientHomeScreen: View {
    @State private var appointments: [AppointmentModel] = []
    @EnvironmentObject var userTypeManager: UserTypeManager
    
    
    var body: some View {
        VStack{
            HStack(spacing:-9){
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .aspectRatio(contentMode: .fit)
                    .padding(.trailing, 10)
                
                
                VStack(alignment: .leading){
                    Text("Hello")
                        .bold()
                        .font(.title)
                        .padding(.leading)
                    
                    Text("Gaurav Ganju")
                        .padding(.horizontal)
                        .font(.title2)
                }
                Spacer()
                
            }
            .padding(.bottom,6)
            
            HStack{
                VitalsView()
            }
            .padding(.bottom,-10)
            .padding(.top,-10)
            
            VStack {
                Text("Health Events")
                    .font(.title)
                    .padding(.leading,-180)
                    .bold()
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: -60){
                        HealthEventTabs(title: "Blood Donation", subTitle: "Camp", time: "09:30 AM Onwards", eventCount: 12, dayOfWeek: "Tue")
                        HealthEventTabs(title: "Blood Donation", subTitle: "Camp", time: "09:30 AM Onwards", eventCount: 12, dayOfWeek: "Tue")
                    }
                    .padding(.leading,-15)
                }
            }
            .padding(.bottom,-8)
            
            
            VStack {
                Text("My Appointments")
                    .font(.title)
                    .bold()
                // Fix alignment by removing hardcoded padding
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                // Appointments list
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(appointments) { appointment in
                            DoctorInfoAppointmentTab(appointment: appointment, backgroundColor: .blue)
                        }
                    }
                }
            }
            .padding(.vertical)
        }
        .background(Color.white.opacity(0.2))
        .onAppear {
            fetchAppointments()
        }
    }
    
    
    private func fetchAppointments() {
        let db = Firestore.firestore()
        let appointmentsRef = db.collection("appointments")
        let today = Date()
        appointmentsRef
            .whereField("PatID", isEqualTo: userTypeManager.userID)
            .whereField("Date", isGreaterThanOrEqualTo: DateFormatter.appointmentDateFormatter.string(from: today))
        
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting appointments: \(error.localizedDescription)")
                } else if let querySnapshot = querySnapshot {
                    var fetchedAppointments: [AppointmentModel] = []
                    for document in querySnapshot.documents {
                        if let appointment = AppointmentModel(document: document.data(), id: document.documentID) {
                            fetchedAppointments.append(appointment)
                        }
                    }
                    // Sort fetched appointments by date and time
                    fetchedAppointments.sort {
                        $0.date < $1.date || ($0.date == $1.date && $0.timeSlot < $1.timeSlot)
                    }
                    DispatchQueue.main.async {
                        self.appointments = fetchedAppointments
                    }
                }
            }
    }
}

extension DateFormatter {
    static let appointmentDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy" // Adjust the date format to match the one used in your Firestore
        return formatter
    }()
}

#Preview {
    PatientHomeScreen()
}
