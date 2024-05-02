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
            DoctorHome()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
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

