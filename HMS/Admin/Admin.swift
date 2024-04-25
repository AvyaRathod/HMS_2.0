//
//  Admin.swift
//  HMS
//
//  Created by Avya Rathod on 22/04/24.
//

import SwiftUI

struct Admin: View {
    var body: some View {
        TabView {
            Text("Home")
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            Text("Record")
                .tabItem {
                    Image(systemName: "book")
                    Text("Record")
                }
            StaffInfoView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.3.fill")
                            .foregroundColor(.red)
                            .frame(width:100, height: 100)
                            .clipShape(Circle())
                            .background(.red)
                        Text("Staff Info")
                    }
                }
            Text("Alert")
                .tabItem {
                    Image(systemName: "light.beacon.max.fill")
                    Text("Alert")
                }
            Text("Health Events")
                .tabItem {
                    Image(systemName: "heart.square.fill")
                    Text("Health Events")
                }
        }
    }
}


#Preview {
    Admin()
}
