//
//  SlotBookView.swift
//  HMS
//
//  Created by Arul Gupta  on 22/04/24.
//


import SwiftUI

struct DoctorCard: View {
    var name: String
    var profession: String
    var rating: Double
    var qualifications: String
    var experience: Int
    let gridItems = Array(repeating: GridItem(.flexible()), count: 3)
    let times = ["9:00", "10:00", "11:00", "12:00", "1:00", "2:00", "3:00", "4:00", "5:00"]
    var slotStatus: [String: Bool] // Dictionary to store slot availability
    
    @State private var selectedSlotIndex: Int? = nil // Track selected slot index
    @State private var selectedDate = Date()
    
    init(name: String, profession: String, rating: Double, qualifications: String, experience: Int) {
        self.name = name
        self.profession = profession
        self.rating = rating
        self.qualifications = qualifications
        self.experience = experience
        
        // Initialize slot status with default availability (all slots available)
        var status = [String: Bool]()
        for time in times {
            status[time] = true
        }
        // Mark some slots as blocked
               status["10:00"] = false
               status["2:00"] = false
               status["4:00"] = false
        self.slotStatus = status
    }
    
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 28)
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [Color.blue.opacity(1), Color.blue.opacity(0.5)]),
                        startPoint: .leading,
                        endPoint: .trailing))
                    .frame(width: 361, height: 180)
                    .shadow(color: Color.black.opacity(0.15), radius: 20)
                
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(name)
                            .font(.title.bold())
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .frame(alignment: .top)
                        HStack {
                            Text(profession)
                                .font(.callout)
                                .foregroundColor(.white)
                            Text(String(format: "(%.1f)", rating))
                                .foregroundColor(.white)
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                        Text(qualifications)
                            .font(.body)
                            .foregroundColor(.white)
                        Text("Experience: \(experience) years")
                            .font(.body)
                            .foregroundColor(.white)
                    }
                    Image(systemName: "person.circle.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 60))
                        .padding(.trailing, 10)
                }
                .padding(.leading, 30)
                Spacer()
            }
            .frame(width: 380, height: 200)
            Text("Appointment Date")
                .font(.headline)
            
            ZStack {
                RoundedRectangle(cornerRadius: 11)
                    .fill(Color(hex: "f5f5f5"))
                    .frame(width: 360, height: 70)
                
                DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(CompactDatePickerStyle())
                        .padding()
                
                
            }
            
            Text("Select a Slot")
                .font(.headline)
            
            ZStack {
                            RoundedRectangle(cornerRadius: 11)
                                .fill(Color(hex: "f5f5f5"))
                                .frame(width: 360, height: 200)
                            
                            LazyVGrid(columns: gridItems, spacing: 10) {
                                ForEach(times, id: \.self) { time in
                                    slotButton(time: time)
                                }
                            }                .padding()
            }
            Button(action: {
                        // Action to perform when the button is tapped
                        print("Button tapped!")
                    }) {
                        // Button label
                        Text("Book Slot")
                            .font(.title3.bold())
                            .padding() // Add padding around the text
                            .foregroundColor(.white) // Set text color
                            .background(Color.blue) // Set background color
                            .cornerRadius(20) // Apply corner radius to create rounded corners
                            .frame(width: 200,height: 100)
                    }
        }
       
    }
    
    @ViewBuilder
        func slotButton(time: String) -> some View {
            let isBooked = !slotStatus[time, default: true] // Check if the slot is booked
            
            Button(action: {
                if !isBooked {
                    selectedSlotIndex = times.firstIndex(of: time) // Update selected slot index when tapped if not booked
                }
            }) {
                RoundedRectangle(cornerRadius: 15)
                    .overlay(
                        Text(time)
                            .font(.headline)
                            .foregroundColor(isBooked ? .gray : .blue)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(isBooked ? Color.gray : Color.blue, lineWidth: 1)
                    )
                    .foregroundColor(selectedSlotIndex == times.firstIndex(of: time) ? .blue : (isBooked ? .white : .clear))
            }
            .frame(width: 90, height: 50)
        }
    
    
}



struct SlotBookView: View {
    var body: some View {
        DoctorCard(name: "Dr. John Doe", profession: "Cardiologist", rating: 4.5, qualifications: "MBBS, MD", experience: 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SlotBookView()
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}
