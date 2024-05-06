import SwiftUI

struct Patient: View {
    @State private var selectedTab: Int = 0 // Track the selected tab index
    
    // Sample patient details
    let patientDetails = PatientDetails(name: "John Doe", id: "123456", age: 35, gender: "Male", email: "johndoe@example.com", address: "123 Main St, Anytown", phoneNumber: "555-1234")
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                PatientHomeScreen()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag(0)
                
                AppointmentsView()
                    .tabItem {
                        Image(systemName: "book")
                        Text("Record")
                    }
                    .tag(1)
                
                SosView()
                    .tabItem {
                        Label("SOS", systemImage: "exclamationmark.circle")
                            .foregroundColor(.red)
                    }
                    .tag(2)
                
                DoctorListView()
                    .tabItem {
                        Image(systemName: "plus.app")
                        Text("Book")
                    }
                    .tag(3)
                
                PatientProfileView(patient: patientDetails) // Pass patient details here
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Account")
                    }
                    .tag(4)
                
                HealthEventsView()
                    .tabItem {
                        Image(systemName: "heart.text.square.fill")
                        Text("Health Events")
                    }
                    .tag(4)
            }
            .navigationBarHidden(true) // Hide the navigation bar
            .navigationBarBackButtonHidden(true)
            
            .onAppear {
                UITabBar.appearance().barTintColor = UIColor.white // Set tab bar color
            }
        }
        .navigationBarBackButtonHidden(true)

    }
}

struct Patient_Previews: PreviewProvider {
    static var previews: some View {
        Patient()
    }
}
