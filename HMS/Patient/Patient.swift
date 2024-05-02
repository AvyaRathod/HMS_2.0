import SwiftUI

struct Patient: View {
    var body: some View {
        TabView {
            PatientHomeScreen()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            AppointmentsView()
                .tabItem {
                    Image(systemName: "book")
                    Text("Appointments")
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
            Text("Tab 5")
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

struct RedCircleView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.red) // Set the circle color
                .frame(width: 100, height: 100) // Set the size of the circle

            Text("SOS")
                .foregroundColor(.white) // Set the text color
                .font(.title) // Set the font of the text
                .fontWeight(.bold) // Make the text bold
        }
    }
}



struct Patient_Previews: PreviewProvider {
    static var previews: some View {
        Patient()
    }
}
