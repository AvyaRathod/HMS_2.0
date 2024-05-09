
//  Admin.swift
//  HMS
//
//  Created by Avya Rathod on 22/04/24.
//

import SwiftUI

struct Admin: View {
    var body: some View {
        TabView {
            AdminHomePage()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            StaffInfoView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Staff Info")
                }
            SOSAdmin()
                .tabItem {
                    VStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.red)
                            .frame(width:100, height: 100)
                            .clipShape(Circle())
                            .background(.red)
                        Text("Alert")
                    }
                }
            AdminEventsView()
                .tabItem {
                    Image(systemName: "heart.text.square.fill")
                    Text("Health events")
                }
          
            
            ManagePatient()
                .tabItem { Image(systemName: "person.3.fill")
                    Text("Admissions") }
        }
        .navigationBarHidden(true) // Hide the navigation bar
        .navigationBarBackButtonHidden(true)
        
        .onAppear {
            UITabBar.appearance().tintColor.customMirror // Set tab bar color
        }
    }
}

struct Admin_Previews: PreviewProvider {
    static var previews: some View {
        Admin()
    }
}
