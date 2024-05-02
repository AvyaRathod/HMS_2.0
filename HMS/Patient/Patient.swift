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
                    Label("SOS", systemImage: "exclamationmark.circle")
                                            .foregroundColor(.red)
                }
            DoctorListView()
                .tabItem {
                    Image(systemName: "plus.app")
                    Text("Book")
                }
            LogoutView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Account")
                }
        }
    }
    
    func sosAction(){
        print("SOS")
    }
}


struct Patient_Previews: PreviewProvider {
    static var previews: some View {
        Patient()
    }
}
