

// Updated by Shashwat Singh

import SwiftUI

struct AppointmentDetails {
    var doctor: String
    var patient: String
    var date: String
    var time: String
}

struct WaveDivider: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        
        path.move(to: CGPoint(x: 0, y: 0))
        
        
        path.addLine(to: CGPoint(x: width, y: 0))
        
        
        path.addQuadCurve(to: CGPoint(x: width * 0.25, y: height * 0.25),
                          control: CGPoint(x: width * 0.125, y: -height * 0.0625))
        
        
        path.addQuadCurve(to: CGPoint(x: width * 0.5, y: 0),
                          control: CGPoint(x: width * 0.375, y: height * 0.0625))
        
        
        path.addQuadCurve(to: CGPoint(x: width * 0.75, y: height * 0.25),
                          control: CGPoint(x: width * 0.625, y: -height * 0.0625))
        
        
        path.addQuadCurve(to: CGPoint(x: width, y: 0),
                          control: CGPoint(x: width * 0.875, y: height * 0.0625))
        
        
        path.addLine(to: CGPoint(x: width, y: 0))
        
        return path
    }
}

struct PaymentConfirmationPage: View {
    var appointmentDetails: AppointmentDetails
    var body: some View {
        NavigationStack{
            VStack {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .foregroundColor(.green.opacity(0.8))
                
                Text("Payment Successful")
                    .font(.system(size: 35))
                    .fontWeight(.bold)
                    .padding(.top, 25)
                
                Text("You have successfully booked an appointment with")
                    .multilineTextAlignment(.center)
                    .padding(.top,-2)
                    
                Text(appointmentDetails.doctor)
                    .multilineTextAlignment(.center)
                    .padding()
                    .padding(.top,-10)
                    .bold()
                    .font(.system(size: 20))
                
                Divider()
                    .background(Color.green)
                    .padding(.horizontal, 20)
                    .frame(height: 2)
                    .padding(.vertical, 20)
                
                HStack {
                    Image(systemName:"person.crop.circle")
                        .foregroundColor(.green)
                    Text(appointmentDetails.patient)
                        .font(.headline)
                    Spacer()
                    Image(systemName:"clock.fill")
                        .foregroundColor(.green)
                    Text(appointmentDetails.time)
                        .font(.headline)
                        .padding(.bottom, 5)
                }
                .padding(.horizontal)
                
                HStack() {
                    Image(systemName:"calendar.circle.fill")
                        .foregroundColor(.green)
                    Text(appointmentDetails.date)
                        .font(.headline)
                        .padding(.bottom, 5)
                    Spacer()
//                    Image(systemName:"number.circle.fill")
//                        .foregroundColor(.green)
//                        .padding(.horizontal,-55)
//                    Text("12345")
//                        .font(.headline)
//                        .padding(.bottom, 5)
//                        .padding(.leading,-10)
                }
                .padding(.horizontal)
                
                Spacer()
                
                
                WaveDivider()
                    .stroke(Color.green, lineWidth: 2)
                    .frame(height: 2)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)
                
                VStack(spacing: 20) {
                    NavigationLink(destination: EmptyView()) {
                        Text("View Appointment")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: PatientHomeScreen()) {
                        Text("Go to Home")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    
                }
                .padding()
                
            }
            .padding()
        }
    }
}


struct PaymentConfirmationPage_Previews: PreviewProvider {
    static var previews: some View {
        let appointment = AppointmentDetails(doctor: "Dr. Kenny Adeola", patient: "Madilyn Doe", date: "19 Nov, 2023", time: "8:30 AM")
        return PaymentConfirmationPage(appointmentDetails: appointment)
    }
}
