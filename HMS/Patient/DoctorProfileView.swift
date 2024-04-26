

import SwiftUI

struct Doctor {
    var name: String
    var specialization: String
    var profileImageName: String
    var Degree: String
}

struct DoctorProfileView: View {
    var doctor: Doctor
    
    var body: some View {
        VStack {
            Text("Doctor")
                .font(.title)
                .padding()
            
            Image("Doc1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250, height: 100)
                .clipShape(Circle())
            
            Text(doctor.name)
                .font(.title)
            
            Text(doctor.specialization)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(doctor.Degree)
                .font(.subheadline)
                .foregroundColor(.gray)
            Spacer()
            
            HStack(alignment: .top, spacing: 20) {
                      VStack {
                          ZStack{
                              Image("People")
                                  .resizable()
//                                  .foregroundColor(.blue)
                                  .frame(width: 50, height: 50)
                                  
                          }
                          .background(Color.blue.opacity(0.1))
                         
                          Text("1000+")
                              .font(.system(size: 20, weight: .bold))
                              .foregroundColor(.blue)
                          Text("Patients")
                              .font(.system(size: 14))
                          
                      }
                      .frame(minWidth: 0, maxWidth: .infinity)
                      .padding(.bottom)
                      .background(Color.white)
                      .cornerRadius(10)
                      .shadow(radius: 5)
                      VStack {
                          ZStack{
                              Image("Badge")
                                  .resizable()
                                  .foregroundColor(.blue)
                                  .frame(width: 50, height: 50)
                          }
                          .background(Color.red.opacity(0.2))
                          Text("10 Yrs")
                              .font(.system(size: 20, weight: .bold))
                              .foregroundColor(.blue)
                          Text("Experience")
                              .foregroundColor(.black)
                              .font(.system(size: 14))
                      }
                      .frame(minWidth: 0, maxWidth: .infinity)
                      .padding(.bottom)
                      .background(Color.white)
                      .cornerRadius(10)
                      .shadow(radius: 5)
                      
                  }

         
                
              Spacer()

                          
        VStack(alignment: .leading){
            Text("About Doctor")
                .font(.system(size: 20, weight: .bold))
            Spacer()
                        .frame(height: 8)
           
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
        
    Spacer()
                .frame(height: 15)
            
        
                Text("Communication")
                    .font(.system(size: 20, weight: .bold))
                     
                HStack{
                    ZStack{
                        Image("Phone")
                            .resizable()
                            .frame(width: 40, height: 40)
                            
                    }
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(10)
                    VStack(alignment: .leading){
                        Text("Phone")
                            .font(.system(size: 16, weight: .semibold))
                        Text("9876543210")
                        
                    }
                }
            HStack{
                ZStack{
                    Image("Mail")
                        .resizable()
                        .frame(width: 40, height: 40)
                        
                }
                .background(Color.red.opacity(0.2))
                .cornerRadius(10)
                VStack(alignment: .leading){
                    Text("Email")
                        .font(.system(size: 16, weight: .semibold))
                    Text("drjohn@gmail.com")
                    
                }
            }
          
            }
            Spacer()
//            Button(action: {
//                isBookingSheetPresented.toggle()
//            }) {
//                Text("Book Appointment")
//                    .padding()
//                    .foregroundColor(.white)
//                    .background(Color.blue)
//                    .cornerRadius(10)
//            }
//            .sheet(isPresented: $isBookingSheetPresented) {
//                AppointmentBookingView(doctor: doctor)
//            }
            
            Spacer()
        }
        
        .padding()
       
    }
}
struct TabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            TabBarItem(imageName: "house.fill", index: 0, selectedTab: $selectedTab)
            Spacer()
            TabBarItem(imageName: "heart.fill", index: 1, selectedTab: $selectedTab)
            Spacer()
            Spacer(minLength: 50) // Adjust the minimum length as needed
            Spacer()
            TabBarItem(imageName: "magnifyingglass", index: 2, selectedTab: $selectedTab)
            Spacer()
            TabBarItem(imageName: "person.fill", index: 3, selectedTab: $selectedTab)
        }
        .padding(.vertical, 8)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}

struct TabBarItem: View {
    let imageName: String
    let index: Int
    @Binding var selectedTab: Int
    
    var body: some View {
        Button(action: {
            selectedTab = index
        }) {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .foregroundColor(selectedTab == index ? .blue : .gray)
                .padding(10)
        }
    }
}

struct DoctorProfileView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorProfileView(doctor: Doctor(name: "Dr.John", specialization: "Orthopedic", profileImageName: "person.fill", Degree: "MBBS"))
    }
}

//struct AppointmentBookingView: View {
//    var doctor: Doctor
//    
//    @State private var selectedDate = Date()
//    @State private var selectedTime = "9:00 AM"
//    
//    var body: some View {
//        VStack {
//            Text("Book Appointment")
//                .font(.title)
//                .padding()
//            
//            Image(doctor.profileImageName)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 100, height: 100)
//                .clipShape(Circle())
//                .padding(.bottom, 20)
//            
//            Text("Doctor: \(doctor.name)")
//                .font(.headline)
//            
//            DatePicker("Select Date", selection: $selectedDate, in: Date()..., displayedComponents: .date)
//                .padding()
//            
//            Picker("Select Time", selection: $selectedTime) {
//                Text("9:00 AM").tag("9:00 AM")
//                Text("10:00 AM").tag("10:00 AM")
//                Text("11:00 AM").tag("11:00 AM")
//                // Add more time options here
//            }
//            .padding()
//            
//            Spacer()
//            
//            Button(action: {
//                // Code for booking appointment
//                // You can add your logic here
//            }) {
//                Text("Confirm Booking")
//                    .padding()
//                    .foregroundColor(.white)
//                    .background(Color.blue)
//                    .cornerRadius(10)
//            }
//            
//            Spacer()
//        }
//        .padding()
//    }
//}
