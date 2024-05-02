//
//  DAppointments.swift
//  HMS
//
//  Created by Sarthak on 30/04/24.
//

import SwiftUI
import Firebase

struct DAppointments: View {
    @EnvironmentObject var userTypeManager: UserTypeManager
    @State private var doctor: DoctorModel?

    @State var storedAppointment: [AppointmentModel] = []
    
    @State var currentWeek: [Date] = []
    @State var currentDay: Date = Date()
    @State var filteredAppointment: [AppointmentModel]?
    @State var DocID = ""
    
    @Namespace var animation
    
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                
                LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]){
                    
                    Section{
                        
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack(spacing: 10){
                                
                                ForEach(currentWeek, id: \.self){ day in
                                    
                                    VStack(spacing: 10){
                                        
                                        Text(extractDate(date: day, format: "EEE"))
                                            .font(.system(size: 14))
                                            .fontWeight(.semibold)
                                        
                                        Text(extractDate(date: day, format: "dd"))
                                            .font(.system(size: 15))
                                            .fontWeight(.bold)
                                        
                                        Circle()
                                            .fill(.yellow)
                                            .frame(width: 8, height: 8)
                                            .opacity(isToday(date: day) ? 1 : 0)
                                        
                                    }
                                    .foregroundColor(isToday(date: day) ? .white : .black)
                                    .frame(width: 45, height: 90)
                                    .background(
                                        ZStack{
                                            if isToday(date: day){
                                                Capsule()
                                                    .fill(.black)
                                                    .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                            }
                                        }
                                    )
                                    .contentShape(Capsule())
                                    .onTapGesture {
                                        currentDay = day
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
        .onAppear{
            fetchDoctor()
            fetchCurrentWeek()
        }
    }
    
    func fetchDoctor() {
            let db = Firestore.firestore()
            let doctorsRef = db.collection("doctors")
            doctorsRef
                .whereField("authID", isEqualTo: userTypeManager.userID)
                .getDocuments { (querySnapshot, error) in
                    if let error = error {
                        print("Error getting doctor: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let querySnapshot = querySnapshot, !querySnapshot.documents.isEmpty,
                          let document = querySnapshot.documents.first else {
                        print("No documents or doctor fetched")
                        return
                    }
                    
                    let doctorData = document.data()
                    let fetchedDoctor = DoctorModel(from: doctorData, id: document.documentID)
                    DispatchQueue.main.async {
                        self.doctor = fetchedDoctor
                        print("Fetched Doctor ID: \(fetchedDoctor.employeeID)")
                        fetchAppointments()
                    }
                }
        }
    
    func fetchAppointments() {
        let db = Firestore.firestore()
        let appointmentsRef = db.collection("appointments")
        appointmentsRef
            .whereField("DocID", isEqualTo: doctor?.employeeID)
            .getDocuments {(querySnapshot, error) in
                if let error = error {
                    print("Error getting appointments: \(error.localizedDescription)")
                    return
                }
                
                guard let querySnapshot = querySnapshot else {
                    print("No documents fetched")
                    return
                }
                
                var fetchedAppointments: [AppointmentModel] = []
                for document in querySnapshot.documents {
                    if let appointment = AppointmentModel(document: document.data(), id: document.documentID) {
                        fetchedAppointments.append(appointment)
                    }
                }
                
                DispatchQueue.main.async {
                    storedAppointment = fetchedAppointments
                    filterTodayAppointments()
                }
            }
    }
    
    func TasksView() -> some View{
        LazyVStack(spacing: 18){
            if let appointments = filteredAppointment{
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
        .onChange(of: currentDay){ newValue in
            fetchAppointments()
            
        }
    }
    
    func AppointmentCardView(appointment: AppointmentModel) -> some View{
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
    
    func filterTodayAppointments() {
        DispatchQueue.global(qos: .userInteractive).async {
            let calendar = Calendar.current
            // Ensure that we compare only the date components (Year, Month, Day)
            let todayStart = calendar.startOfDay(for: self.currentDay)

            let filtered = self.storedAppointment.filter { appointment in
                let appointmentDay = calendar.startOfDay(for: appointment.date)
                return appointmentDay == todayStart
            }

            DispatchQueue.main.async {
                withAnimation {
                    self.filteredAppointment = filtered
                    print("Filtered Appointments: \(self.filteredAppointment?.count ?? 0)")
                }
            }
        }
    }


    
    func fetchCurrentWeek(){
        let today = Date()
        let calendar = Calendar.current
       
        
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        guard let firstWeekDay = week?.start else{
             return
         }
         // Iterating to get the full week
        (0..<7).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay) {
                currentWeek.append(weekday)
            }
        }

    }
    
    func extractDate(date: Date, format: String) -> String{
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    func isToday(date: Date) -> Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(currentDay, inSameDayAs: date)
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
  let appointment: AppointmentModel
    
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
