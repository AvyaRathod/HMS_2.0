//
//  Doc.swift
//  HMS
//
//  Created by Avya Rathod on 22/04/24.
//

import SwiftUI

struct Doc: View {
    var body: some View {
        TabView{
            LogoutView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            DAppointments()
                .tabItem {
                    Image(systemName: "house")
                    Text("Appointments")
                }
            DoctorHealthEventsView(events: sampleHealthEvents)
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Events")
                }
            
        }
    }
}


#Preview {
    Doc()
}

