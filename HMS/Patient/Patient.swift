import SwiftUI

struct Patient: View {
    var body: some View {
        TabView {
            PatientHomeScreen()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            Text("Tab 2")
                .tabItem {
                    Image(systemName: "book")
                    Text("Record")
                }
            Text("Tab 3")
                .tabItem {
                    VStack {
                        Image(systemName: "sos")
                            .foregroundColor(.red)
                            .frame(width:100, height: 100)
                            .clipShape(Circle())
                            .background(.red)
                        Text("SOS")
                    }
                }
            DoctorListView()
                .tabItem {
                    Image(systemName: "plus.app")
                    Text("Book")
                }
            Text("Tab 5")
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Account")
                }
        }
    }
}

struct Patient_Previews: PreviewProvider {
    static var previews: some View {
        Patient()
    }
}
