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
            AdminHome()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            Text("Tab 2")
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Staff Info")
                }
            Text("Tab 3")
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
            Text("Tab 4")
                .tabItem {
                    Image(systemName: "heart.text.square.fill")
                    Text("Health events")
                }
        }
    }
}


#Preview {
    Admin()
}
