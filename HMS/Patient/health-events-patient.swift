//
//  health-events-patient.swift
//  HMS
//
//  Created by Protyush Kundu on 29/04/24.
//
import SwiftUI


// Model to represent a health event
struct HealthEventsView: View {
    @State private var showConfirmationAlert = false
    var events: [HealthEvent]
    
    var body: some View {
        NavigationView {
            List(events, id: \.title) { event in
                VStack(alignment: .leading, spacing: 8) {
                    Image(event.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 150)
                        .clipped()
                        .cornerRadius(10)
                    
                    Text(event.title)
                        .font(.headline)
                    Text(event.description) // Display event description
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("Date: \(event.date)")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    Text("Time: \(event.time)")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    Text("Venue: \(event.venue)")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
                .contentShape(Rectangle()) // Set the content shape to rectangle to ensure the whole view is tappable
                .onTapGesture {
                    // Handle tapping on event details
                    // You can add any custom action here if needed
                }
                
                // Attend Button
                Button(action: {
                    // Log the event when the "Attend" button is clicked
                    logEvent(event)
                    // Show confirmation alert
                    showConfirmationAlert.toggle()
                }) {
                    Text("Attend")
                        .font(.headline)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 20)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.top, 8)
                }
            }
            .navigationTitle("Health Events")
            .alert(isPresented: $showConfirmationAlert) {
                Alert(title: Text("Thank You!"), message: Text("You have confirmed attendance for this event."), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    // Function to log the event
    func logEvent(_ event: HealthEvent) {
        print("Attending \(event.title)")
        // Add your logic to log the event here
    }
}

struct HealthEventsView_Previews: PreviewProvider {
    static var previews: some View {
        HealthEventsView(events: sampleHealthEvents)
    }
}
