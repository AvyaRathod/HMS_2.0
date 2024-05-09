//
//  HomePage.swift
//  HMS
//
//  Created by admin on 06/05/24.
//

import SwiftUI
import Combine
import Firebase

struct HomeScreenView: View {
    @State private var appointments: [AppointmentModel] = []
    @EnvironmentObject var userTypeManager: UserTypeManager
    
    @State private var pName: String = "Loading..."

    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment: .leading) {
                    WelcomeHeaderView(userName: pName)
                    HealthVitalsView()
                    BookView()
                    UpcomingAppointmentCardView(appointments: appointments)
                }
            }
                
            
            .background(Color(.systemGroupedBackground))
            .onAppear {if !userTypeManager.userID.isEmpty {
                fetchPName()
                fetchAppointments()
            }
            }
        }
        .ignoresSafeArea(.container, edges: .top)
    }

    private func fetchPName() {
        let db = Firestore.firestore()
        let documentID = userTypeManager.userID
        db.collection("Patients").document(documentID).getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                if let patientName = data?["name"] as? String {
                    print("Patient Name: \(patientName)")
                    pName=patientName
                } else {
                    print("Patient name not found in the document.")
                }
            } else {
                print("Document does not exist or error: \(error?.localizedDescription ?? "Unknown error")")
            }
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


struct WelcomeHeaderView: View {
    var userName: String
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text("Hey, \(userName)")
                    .font(.title)
                    .fontWeight(.bold)
                Text("How are you feeling today?")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            NavigationLink(destination:PatientProfileView()) {
                VStack(alignment: .trailing){
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 40, height: 40) // Adjust the size of the profile pic here
                        .clipShape(Circle()) // Make the profile pic round
                }
            }
        }
        .padding()
    }
}

struct HealthVitalsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Health Vitals")
                . font(. system(size: 22))
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    VitalsView()
                }
                
            }
        }
    }
}


struct UpcomingAppointmentCardView: View {
    var appointments: [AppointmentModel]
    @State private var appointmenta: [AppointmentModel] = []
    
    var body: some View {
        Text("Upcoming Appointments")
            . font(. system(size: 22))
            .font(.headline)
            .fontWeight(.semibold)
            .padding(.horizontal)
        ScrollView(.horizontal, showsIndicators: false) {
            
                    HStack(spacing: 20) {
                        ForEach(appointments) { appointment in
                            AppointmentCardView(appointment: appointment, appointments: $appointmenta)
                        }
                    }

                    .padding(.bottom)
                }
            }
        }


struct BookView: View {
    var body: some View {
        ZStack{
            NavigationView {
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Feeling Unwell?")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Text("Get Expert")
                                .font(.system(size: 18))
                                .multilineTextAlignment(.leading)
                            Text("Consultation from our ")
                                .font(.system(size: 18))
                                .multilineTextAlignment(.leading)
                            Text("Renowned Doctors!")
                                .font(.system(size: 18))
                                .multilineTextAlignment(.leading)
                        }
                        
                        Rectangle()
                            .fill(Color.white)
                            .frame(width:70, height: 200)
                            .cornerRadius(30)
                            .padding(.leading, 60)
                            .overlay(
                                Image("HomeDoc")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .foregroundColor(.white)
                            )
                    }
                    
                    NavigationLink(destination: DoctorListView()) {
                        Text("Book Now")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.customBlue)
                            .cornerRadius(11)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(11)
                .shadow(radius: 4)
                .padding()
            }

        }
    }
}

struct AppointmentCardView: View {
    var appointment: AppointmentModel
    @Binding var appointments: [AppointmentModel] 
    @State private var doctorName: String = "Loading..."
    @State private var specialisation: String = "Loading..."
    @State private var doctorImageURL: String? = nil
    
    var body: some View {
        ZStack{
            HStack{
                
                if let urlStr = doctorImageURL, let url = URL(string: urlStr) {
                                    AsyncImage(url: url) { image in
                                        image.resizable().clipShape(RoundedRectangle(cornerRadius: 11.0)).frame(width: 100, height: 120)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 150)
                                    .clipped()
                                    .cornerRadius(10)
                                } else {
                                    Rectangle()
                                        .fill(Color.white)
                                        .frame(width: 300, height: 130)
                                        .cornerRadius(30)
                                        .padding(.leading, 60)
                                        .frame(minWidth: 300,minHeight: 150)
                                }
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
                        cancelAppointment()
                    }) {
                        Text("Cancel")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(Color.customBlue)
                            .cornerRadius(11)
                    }
                }
            }
                .padding()
                .background(Color.white)
                .cornerRadius(11)
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
                self.doctorImageURL = data["image"] as? String
            } else {
                print("No matching document found for DocID \(self.appointment.doctorID)")
                self.doctorName = "Doctor not found."
                self.specialisation = "Specialisation unknown."
            }
        }
    }
    
    private func cancelAppointment() {
        let db = Firestore.firestore()
        db.collection("appointments").document(appointment.id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
                if let index = self.appointments.firstIndex(where: { $0.id == self.appointment.id }) {
                    DispatchQueue.main.async {
                        self.appointments.remove(at: index)
                    }
                }
            }
        }
    }
        
}

extension DateFormatter {
    static let appointmentDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
}


struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
