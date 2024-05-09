//
//  pcount.swift
//  HMS
//
//  Created by Protyush Kundu on 08/05/24.
//
//  pcount.swift
//  HMS
//
//  Created by Protyush Kundu on 08/05/24.
//
import SwiftUI
import Firebase
import FirebaseFirestore

struct TotalUsersView: View {
    @State private var totalUsers: Int = 0
    @State private var totalAppointments: Int = 0
    @State private var totalPrescriptions: Int = 0
    @State private var totalEarnings: Int = 0
    
    // Custom colors
    let blueShade = Color(red: 24/255, green: 116/255, blue: 205/255)
    let darkBlue = Color(red: 2/255, green: 71/255, blue: 144/255)
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(LinearGradient(gradient: Gradient(colors: [darkBlue.opacity(0.8), blueShade.opacity(0.8)]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: 150, height: 100)
                    .overlay(
                        VStack {
                            Text("Total Users")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.top)
                            Text("\(totalUsers)")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                    )
                   
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(LinearGradient(gradient: Gradient(colors: [darkBlue.opacity(0.8), blueShade.opacity(0.8)]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: 150, height: 100)
                    .overlay(
                        VStack {
                            Text("Total Appointments")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.top)
                            Text("\(totalAppointments)")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                    )
                    
                RoundedRectangle(cornerRadius: 20)
                    .fill(LinearGradient(gradient: Gradient(colors: [darkBlue.opacity(0.8), blueShade.opacity(0.8)]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: 150, height: 100)
                    .overlay(
                        VStack {
                            Text("Total Prescriptions")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.top)
                            Text("\(totalPrescriptions)")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                    )
                    
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(LinearGradient(gradient: Gradient(colors: [darkBlue.opacity(0.8), blueShade.opacity(0.8)]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: 150, height: 100)
                    .overlay(
                        VStack {
                            Text("Total Earnings")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.top)
                            Text("Rs. \(totalEarnings)")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                    )
                    
            }
            .padding(.horizontal)
        }
        .onAppear {
            fetchTotalUsers()
            fetchTotalAppointments()
            fetchTotalPrescriptions()
            // Start a timer to periodically update the counts
           
        }
    }
    
    
    func fetchTotalUsers() {
        let db = Firestore.firestore()
        let patientsCollection = db.collection("Patients")
        
        patientsCollection.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }
            
            self.totalUsers = documents.count
        }
    }
    
    func fetchTotalAppointments() {
        let db = Firestore.firestore()
        let appointmentsCollection = db.collection("appointments")
        
        appointmentsCollection.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }
            
            self.totalAppointments = documents.count
            calculateTotalEarnings()
        }
    }
    
    func fetchTotalPrescriptions() {
        let db = Firestore.firestore()
        let prescriptionsCollection = db.collection("prescriptions")
        
        prescriptionsCollection.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }
            
            self.totalPrescriptions = documents.count
           
        }
    }
    
    func calculateTotalEarnings() {
        totalEarnings = totalAppointments * 1000
    }
}

struct TotalUsersView_Previews: PreviewProvider {
    static var previews: some View {
        TotalUsersView()
    }
}
