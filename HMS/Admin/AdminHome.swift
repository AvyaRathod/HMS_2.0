import SwiftUI

struct AdminHomePage: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 10) {
                    HStack {
                        Text("Hey Admin                        ")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.leading)
                        
                        NavigationLink(destination: AdminProfile(admin: AdminDetails(name: "Admin Name", email: "admin@example.com", contact: "123-456-7890"))) {
                            Image(systemName: "person.circle")
                                .font(.title)
                        }
                        .padding(.trailing)
                    }
                    
                    TotalUsersView()
                        .padding(.horizontal)
                    
                    // Add more views/components below
                    MonthlyAppointmentsChartView()
                }
                .padding(.top, 20) // Adjusted top padding to add space between the components and the top edge
            }
            .navigationBarTitleDisplayMode(.inline) // Set navigation bar title display mode to inline
        }
    }
}

struct AdminHomePage_Previews: PreviewProvider {
    static var previews: some View {
        AdminHomePage()
    }
}
