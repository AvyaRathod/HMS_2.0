//
//  SOSAdmin.swift
//  HMS
//
//  Created by Anant on 02/05/24.
//


import SwiftUI

struct SOSAdmin: View {
    @StateObject private var emergencyViewModel = EmergencyViewModel()
    @State private var timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    var body: some View {
        ScrollView{
            VStack(spacing: 20) {
                
                ForEach(emergencyViewModel.emergencies, id: \.self) { emergency in
                    LocationCard(name: emergency.patientId,
                                 latitude: emergency.latitude,
                                 longitude: emergency.longitude,
                                 dateTime: formattedDate(from: emergency.timeStamp))
                }
                
            }
            .padding()
            .onAppear {
                emergencyViewModel.getAllEmergencies()
            }
            .onReceive(timer) { _ in
                                emergencyViewModel.getAllEmergencies()
                            }
            
        }
    }
    
    private func formattedDate(from date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm a"
            return formatter.string(from: date)
        }
    
}
struct LocationCard: View {
    let name: String
    let latitude: String
    let longitude: String
    let dateTime: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(name)
                .font(.title)
            Text("Location:")
                .font(.headline)
            Text("Latitude: \(latitude), Longitude: \(longitude)")
                .font(.subheadline)
            Text("Date & Time: \(dateTime)")
                .font(.subheadline)
            HStack {
                Spacer()
                Button(action: {
                    openMaps(latitude: latitude, longitude: longitude)
                }) {
                    Text("Locate")
                        .foregroundStyle(Color.white)
                }
               
                .fontWeight(.heavy)
                .font(.title3)
                .frame(width:300)
                .padding()
                .foregroundColor(.white)
                .background(Color(Color.black))
                .cornerRadius(40)
        }.padding()
        }
//        .padding()
        .background(Color.white)
        .border(Color.black)
    }

    func openMaps(latitude: String, longitude: String) {
        if let url = URL(string: "http://maps.apple.com/?q=\(latitude),\(longitude)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
}


struct SOSAdmin_Previews: PreviewProvider {
    static var previews: some View {
        SOSAdmin()
    }
}
