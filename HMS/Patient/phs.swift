//
//  phs.swift
//  HMS
//
//  Created by admin on 03/05/24.
//

import SwiftUI
import Combine

struct HomeScreenView: View {
    var body: some View {
        NavigationView {
            
            ScrollView {
                VStack(alignment: .leading) {
                    WelcomeHeaderView(userName: "Johnson")
                    HealthVitalsView()
                    BookView()
                    UpcomingAppointmentCardView()
                }
                                   
            }
            .background(Color(.systemGroupedBackground))
        }
    }
}


struct WelcomeHeaderView: View {
    var userName: String
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text("Hey, \(userName)")
                    .font(.title)
                    .fontWeight(.bold)
                Text("How are you feeling today?")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing){
                Image("profilepic")
                    .resizable()
                    .frame(width: 55, height: 60) // Adjust the size of the profile pic here
                    .clipShape(Circle()) // Make the profile pic round
            }
        
        }
        .padding()
    }
}

struct HealthVitalsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Health Vitals")
                . font(. system(size: 22))
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    VitalsView()
                }
                
            }
        }
    }
}


struct UpcomingAppointmentCardView: View {
    var body: some View {
        Text("Upcoming Appointments")
            . font(. system(size: 22))
            .font(.headline)
            .fontWeight(.semibold)
            .padding(.horizontal)

        ZStack{
            HStack{
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 100, height: 130)
                    .cornerRadius(30)
                    .padding(.leading, 60)
                    .overlay(
                                                Image("DrPriyaPhoto")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    
                                                    .foregroundColor(.white)
                                            )

                VStack(alignment: .leading) {
                    Text("Dr.Priya")
                        .font(.title3)
                        .fontWeight(.semibold)
                    HStack{
                        Text("Cardiologist")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text("|")
                            .foregroundColor(.secondary)
                        Text("MBBS,MD")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Text("Date: 5 May 2023")
                    Text("Time:2:30pm")
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Text("View Appointment")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.navy)
                            .cornerRadius(8)
                    }
                    
                }
                
               
                
            }
            
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 4)
        .padding(.bottom)
        .padding(.leading)
        .padding(.trailing)
    }
    
}

struct BookView: View {
    var body: some View {
        ZStack{
            VStack{
              
                HStack{
                    
                    VStack(alignment: .leading) {
                        Text("Unlocking Health Access")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Text("25% OFF on\nYour first video consultant")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                    }
                    Spacer()
                    Rectangle()
                        .fill(Color.blueShade.opacity(0.2))
                        .frame(width: 100, height: 130)
                        .cornerRadius(30)
                        .padding(.leading, 60)
                        .overlay(
                                                    Image("homedoc")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        
                                                        .foregroundColor(.white)
                                                )
                }
                Button(action: {}) {
                    Text("Book Now")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.navy)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 4)
        .padding()
    }
}


struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
