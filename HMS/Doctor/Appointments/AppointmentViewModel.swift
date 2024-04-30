//
//  AppointmentViewModel.swift
//  HMS
//
//  Created by Sarthak on 30/04/24.
//

import SwiftUI
import Firebase

struct Appointments: Identifiable {
    let id: String
    let doctorID: String
    let patientID: String
    let bill: Int
    let date: Date
    let timeSlot: String
    let isComplete: Bool
    let reason: String
    
    // Additional fields to store doctor's details after fetching
    var patientName: String?
    var doctorName: String?
    var doctorSpecialisation: String?
    // Any additional fields for doctor details here...
}

class AppointmentViewModel: ObservableObject{
    
    
    @Published var storedAppointment: [Appointments] = [
        Appointments(
            id: "appointment1",
            doctorID: "doctor123",
            patientID: "patient456",
            bill: 100,
            date: Date(timeIntervalSince1970: 1714765695), // Adjust timestamp as needed
            timeSlot: "10:00 AM",
            isComplete: true,
            reason: "General checkup",
            patientName: "John Doe",
            doctorName: "Dr. Jane Smith",
            doctorSpecialisation: "Cardiology"
          ),
    ]
    
    @Published var currentWeek: [Date] = []
    
    @Published var currentDay: Date = Date()
    
    @Published var filteredAppointment: [Appointments]?

    
    init(){
        fetchCurrentWeek()
        filterTodayAppointments()
    }
    
//    func fetchAppointments() {
//        let db = Firestore.firestore()
//        let appointmentsRef = db.collection("appointments")
//        let today = Date()
//        appointmentsRef
//            .whereField("DocID", isEqualTo: userTypeManager.userID)
//            .whereField("Date", isGreaterThanOrEqualTo: DateFormatter.appointmentDateFormatter.string(from: today))
//        
//            .getDocuments { (querySnapshot, error) in
//                if let error = error {
//                    print("Error getting appointments: \(error.localizedDescription)")
//                } else if let querySnapshot = querySnapshot {
//                    var fetchedAppointments: [AppointmentModel] = []
//                    for document in querySnapshot.documents {
//                        if let appointment = AppointmentModel(document: document.data(), id: document.documentID) {
//                            fetchedAppointments.append(appointment)
//                        }
//                    }
//                    // Sort fetched appointments by date and time
//                    fetchedAppointments.sort {
//                        $0.date < $1.date || ($0.date == $1.date && $0.timeSlot < $1.timeSlot)
//                    }
//                    DispatchQueue.main.async {
//                        self.storedAppointment = fetchedAppointments
//                    }
//                }
//            }
//    }
    
    func filterTodayAppointments() {
            DispatchQueue.global(qos: .userInteractive).async {
                let calendar = Calendar.current
                let filtered = self.storedAppointment.filter { appointment in
                    return calendar.isDate(appointment.date, inSameDayAs: self.currentDay)
                }

                DispatchQueue.main.async {
                    withAnimation {
                        self.filteredAppointment = filtered
                    }
                }
            }
        }
    
    
    func fetchCurrentWeek(){
        let today = Date()
        let calendar = Calendar.current
       
        
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        guard let firstWeekDay = week?.start else{
             return
         }
         // Iterating to get the full week
        (0..<7).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay) {
                currentWeek.append(weekday)
            }
        }

    }
    
    func extractDate(date: Date, format: String) -> String{
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    func isToday(date: Date) -> Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(currentDay, inSameDayAs: date)
    }

    
}
