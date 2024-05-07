

import SwiftUI

struct DoctorProfileView: View {
    var doctor: DoctorModel
    
    var body: some View {
        VStack {
            Text("Doctor")
                .font(.title)
                .padding()
            if let url = URL(string: doctor.image) {
                AsyncImage(url: url) { image in
                    image.resizable().clipShape(Circle()).frame(width: 150, height: 150)
                } placeholder: {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fill)
                .frame(height: 150)
                .clipped()
                .cornerRadius(10)
            }

            
            Text(doctor.name)
                .font(.title)
            
            Text(doctor.specialisation)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(doctor.degree)
                .font(.subheadline)
                .foregroundColor(.gray)
            Spacer()
            
            HStack(alignment: .top, spacing: 20) {
                      VStack {
                          ZStack{
                              Image("People")
                                  .resizable()
                                  .frame(width: 50, height: 50)
                          }
                          .background(Color.blue.opacity(0.1))
                         
                          Text("")
                              .font(.system(size: 20, weight: .bold))
                              .foregroundColor(.blue)
                          Text("Appointments")
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
                        Text(doctor.contact)
                        
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
                    Text(doctor.email)
                    
                }
            }
          
            }
            Spacer()
        }
        
        .padding()
       
    }
}

