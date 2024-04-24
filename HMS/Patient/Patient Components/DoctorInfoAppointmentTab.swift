import SwiftUI

struct DoctorInfoAppointmentTab: View {
    var backgroundColor: Color
    
    var body: some View {
        VStack{
            
                ZStack {
                    backgroundColor
                        .opacity(0.8)
                        .frame(width: 360, height: 120)
                        .cornerRadius(10)
                    
                    HStack(spacing: 15) {
                        Image(systemName: "person.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 70, height: 70)
                        
                        VStack(alignment: .leading){
                            Text("Doctor Name")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Text("Dermatologist")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("08:30 - 09:30")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("Token: 3")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        Button(action: {
                            // Action
                        }) {
                            Text("Cancel")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.red.opacity(0.8))
                                .cornerRadius(10)
                                .frame(width: 100, height: 20)
                        }
                    }
                    Spacer()
                }
                .padding(.leading, 10)
            }
        }
    
}
#Preview {
    DoctorInfoAppointmentTab(backgroundColor: .blue)
}
