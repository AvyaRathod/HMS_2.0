//
//  DAppointments.swift
//  HMS
//
//  Created by Sarthak on 30/04/24.
//

import SwiftUI

struct DAppointments: View {
    @StateObject var AppointmentsModel: AppointmentViewModel = AppointmentViewModel()
    @Namespace var animation
    var body: some View {
        NavigationView{ 
            ScrollView(.vertical, showsIndicators: false){
                
                LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]){
                    
                    Section{
                        
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack(spacing: 10){
                                
                                ForEach(AppointmentsModel.currentWeek, id: \.self){ day in
                                    
                                    VStack(spacing: 10){
                                        
                                        Text(AppointmentsModel.extractDate(date: day, format: "EEE"))
                                            .font(.system(size: 14))
                                            .fontWeight(.semibold)
                                        
                                        Text(AppointmentsModel.extractDate(date: day, format: "dd"))
                                            .font(.system(size: 15))
                                            .fontWeight(.bold)
                                        
                                        Circle()
                                            .fill(.yellow)
                                            .frame(width: 8, height: 8)
                                            .opacity(AppointmentsModel.isToday(date: day) ? 1 : 0)
                                        
                                    }
                                    .foregroundColor(AppointmentsModel.isToday(date: day) ? .white : .black)
                                    .frame(width: 45, height: 90)
                                    .background(
                                        ZStack{
                                            if AppointmentsModel.isToday(date: day){
                                                Capsule()
                                                    .fill(.black)
                                                    .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                            }
                                        }
                                    )
                                    .contentShape(Capsule())
                                    .onTapGesture {
                                        AppointmentsModel.currentDay = day
                                    }
                                    
                                }
                                
                            }
                            .padding(.horizontal)
                        }
                        TasksView()
                        
                    } header: {
                        HeaderView()
                    }
                }
            }
            .ignoresSafeArea(.container, edges: .top)
        }
    }
    
    func TasksView() -> some View{
        LazyVStack(spacing: 18){
            if let appointments = AppointmentsModel.filteredAppointment{
                if appointments.isEmpty{
                    Text("No Appoinments!!!")
                        .font(.system(size: 16))
                        .fontWeight(.light)
                        .offset(y: 100)
                }
                else{
                    ForEach(appointments){ appointment in
                        NavigationLink { // Use NavigationLink for task details screen
                            AppointmentDetailsView(appointment: appointment) // Pass selected task
                                    } label: {
                                        AppointmentCardView(appointment: appointment)
                                    }
                    }
                }
            }
            else{
                ProgressView()
                    .offset(y: 100)
            }
        }
        .padding()
        .padding(.top)
        .onChange(of: AppointmentsModel.currentDay){ newValue in
            AppointmentsModel.filterTodayAppointments()
            
        }
    }
    
    func AppointmentCardView(appointment: Appointments) -> some View{
        HStack(alignment: .top, spacing: 30){
            VStack(spacing: 10){
                Circle()
                    .fill(.black)
                    .frame(width: 15, height: 15)
                    .background(
                        
                        Circle()
                            .stroke(.black, lineWidth: 1)
                            .padding(-3)
                    )
                Rectangle()
                    .fill(.black)
                    .frame(width: 3)
            }
            
            VStack{
                
                HStack(alignment: .top, spacing: 10){
                    VStack(alignment: .leading, spacing: 12){
                        
                        Text(appointment.patientID)
                            .font(.title2.bold())
                        
                        Text(appointment.reason)
                            .font(.title3)
                            //.foregroundStyle(.secondary)
                    }
                    .hLeading()
                    
                    Text(appointment.timeSlot)
                }
                
                
            }
            .foregroundColor(.white)
            .padding()
            .hLeading()
            .background(
                Color(.black)
                    .cornerRadius(25)
            )
        }
        .hLeading()
    }
    
    func HeaderView() -> some View{
        HStack(spacing: 10){
            VStack(alignment: .leading, spacing: 10){
                
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .foregroundStyle(.gray)
                
                Text("Today")
                    .font(.largeTitle.bold())

            }
            .hLeading()
        }
        .padding()
        .padding(.top, getSafeArea().top)
        .background(Color.white)
    }
}

extension View{
    func hLeading() -> some View{
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func hTrailing() -> some View{
        self
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    func hCenter() -> some View{
        self
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
    func getSafeArea() -> UIEdgeInsets{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else{
            return .zero
        }
        return safeArea
    }
}

struct AppointmentDetailsView: View {
  let appointment: Appointments // Property to hold the selected task

  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      Text(appointment.patientName!)
        .font(.title2.bold())

      Text(appointment.reason)
        .font(.title3)

      Text(appointment.timeSlot)

      // Add more details as needed (e.g., location, attendees)
    }
    .padding()
    .navigationTitle(appointment.patientName!) // Set navigation title using task title
  }
}


#Preview {
    DAppointments()
}
