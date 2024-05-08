import SwiftUI

struct DLeaveAppView: View {
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var reason = ""
    @State private var selectedSlots: [String] = []
    let gridItems = Array(repeating: GridItem(.flexible()), count: 3)
    let times = ["9:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00"]
    let bookedSlots: [String] = []

    var body: some View {
        ScrollView{
            Text("Leave Application")
                .font(.largeTitle)
               
            VStack {
                ZStack{
                    RoundedRectangle(cornerRadius: 11)
                        .foregroundColor(Color.blueShade.opacity(0.1))
                        .shadow(radius: 5)
                        .frame(width: 400, height: 150)
                    
                    VStack{
                        HStack {
                            Text("Start date")
                                .foregroundColor(.black)
                                .font(.headline)
                                .padding(.leading, 25)
                            
                            Spacer()
                            
                            DatePicker("", selection: $startDate, in: Date()..., displayedComponents: .date)
                                .datePickerStyle(CompactDatePickerStyle())
                                .labelsHidden()
                                .padding(.trailing, 25)
                                .onChange(of: startDate) { newStartDate in
                                    if newStartDate > endDate {
                                        endDate = newStartDate
                                    }
                                }
                        }
                        
                        HStack {
                            Text("End date")
                                .foregroundColor(.black)
                                .font(.headline)
                                .padding(.leading, 25)
                            
                            Spacer()
                            
                            DatePicker("", selection: $endDate, in: Date()..., displayedComponents: .date)
                                .datePickerStyle(CompactDatePickerStyle())
                                .labelsHidden()
                                .padding(.trailing, 25)
                                .onChange(of: endDate) { newEndDate in
                                    if newEndDate < startDate {
                                        startDate = newEndDate
                                    }
                                }
                        }
                    }
                }
                
                Text("Why are you taking a leave?")
                    .font (.title3)
                    .fontWeight (.semibold)
                
                ZStack{
                    RoundedRectangle(cornerRadius: 11)
                        .foregroundColor(Color.blueShade.opacity(0.1))
                        .shadow(radius: 5)
                        .frame(width: 400, height: 55)
                    
                    TextField("  reason", text: $reason)
                        .frame(height: 40)
                        .padding()
                        .cornerRadius(11)
                }
                
                if Calendar.current.isDate(startDate, inSameDayAs: endDate) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 11)
                            .fill(Color(hex: "f5f5f5"))
                            .frame(width: 360, height: 200)
                        
                        LazyVGrid(columns: gridItems, spacing: 10) {
                            ForEach(times, id: \.self) { time in
                                LeaveButton(time: time, bookedSlots: bookedSlots, selectedDate: startDate, selectedSlots: $selectedSlots)
                                    .onTapGesture {
                                        if let index = selectedSlots.firstIndex(of: time) {
                                            selectedSlots.remove(at: index)
                                        } else {
                                            selectedSlots.append(time)
                                        }
                                    }
                            }
                        }
                        .padding()
                    }
                }
                
                Button(action: {
                    // Handle the submission of the leave application
                }) {
                    Text("Submit")
                        .font(.title3.bold())
                        .padding() // Add padding around the text
                        .foregroundColor(.white) // Set text color
                        .background(Color.customBlue) // Set background color
                        .cornerRadius(11) // Apply corner radius to create rounded corners
                        .frame(width: 200,height: 100)
                }
            }
            .padding()
        }
    }
}

struct LeaveButton: View {
    var time: String
    var bookedSlots: [String]
    var selectedDate: Date
    @Binding var selectedSlots: [String] // Change this to selectedSlots
    
    let currentTime = Calendar.current.dateComponents([.hour, .minute], from: Date())
    
    var body: some View {
        let isBooked = bookedSlots.contains(time)
        let isSelected = selectedSlots.contains(time) // Change this line
        let isPastSlot = !isFutureTimeSlot(time)
        let isSelectable = !isBooked && !isPastSlot
        
        Button(action: {
            if isSelectable {
                if let index = selectedSlots.firstIndex(of: time) {
                    selectedSlots.remove(at: index)
                } else {
                    selectedSlots.append(time)
                }
            }
        }) {
            RoundedRectangle(cornerRadius: 11)
                .fill(isBooked ? Color.white : (isSelected ? Color.customBlue : (isPastSlot ? Color.white : Color.white)))
                .overlay(
                    Text(time)
                        .font(.headline)
                        .foregroundColor(isBooked ? .gray : (isSelected ? .white :(isPastSlot ? Color.gray : Color.customBlue)))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 11)
                        .stroke(isBooked ? Color.gray : Color.customBlue, lineWidth: 1)
                )
                .opacity(isBooked ? 0.5 : 1.0)
                .disabled(!isSelectable)
        }
        .frame(width: 90, height: 50)
    }
    
    func isFutureTimeSlot(_ time: String) -> Bool {
        let slotComponents = time.components(separatedBy: ":")
        guard let hour = Int(slotComponents[0]), let minute = Int(slotComponents[1]) else {
            return false
        }
        
        let calendar = Calendar.current
        let slotDate = calendar.date(bySettingHour: hour, minute: minute, second: 0, of: selectedDate)!
        
        return slotDate > Date()
    }
}


struct LeaveApplicationView_Previews: PreviewProvider {
    static var previews: some View {
        DLeaveAppView()
    }
}
