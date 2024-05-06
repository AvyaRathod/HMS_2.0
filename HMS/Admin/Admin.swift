
//  Admin.swift
//  HMS
//
//  Created by Avya Rathod on 22/04/24.
//

import SwiftUI

struct Admin: View {
    var body: some View {
        TabView {
            AdminHome()
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
            AdminProfile(admin: AdminDetails(name: "Admin Name", email: "admin@example.com", contact: "123-456-7890")) // Add AdminProfile view as a tab item
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("Profile")
                }
        }
    }
}

struct Admin_Previews: PreviewProvider {
    static var previews: some View {
        Admin()
    }
}
