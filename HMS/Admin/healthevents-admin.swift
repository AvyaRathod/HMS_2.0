//
//  healthevents-admin.swift
//  HMS
//
//  Created by Protyush Kundu on 30/04/24.
//

import SwiftUI

struct AdminHealth: View {
    var body: some View {
        Text("Admin Home")
    }
}

struct AdminEventsView: View {
    @State private var events: [HealthEvent]
    @State private var showAddEventSheet = false
    
    init(events: [HealthEvent]) {
        self._events = State(initialValue: events)
    }
    
    var body: some View {
        NavigationView {
            List(events, id: \.id) { event in
                VStack(alignment: .leading, spacing: 8) {
                    if !event.imageName.isEmpty {
                        Image(event.imageName)
                            .resizable()
                            .frame(width: 300, height: 150)
                            .aspectRatio(contentMode: .fit)
                            .clipped()
                    }
                    Text(event.title)
                        .font(.title)
                    Text("\(event.description)")
                        .font(.headline)
                        .foregroundColor(.primary.opacity(0.5))
                    Text("Date: \(event.date)")
                        .font(.title3)
                        .foregroundColor(.primary)
                    Text("Time: \(event.time)")
                        .font(.title3)
                        .foregroundColor(.primary)
                    Text("Venue: \(event.venue)")
                        .font(.title3)
                        .foregroundColor(.primary)
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Health Events")
            .navigationBarItems(trailing:
                Button(action: {
                    showAddEventSheet.toggle()
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showAddEventSheet) {
                AddEventView(events: $events)
            }
        }
    }
}



struct AddEventView: View {
    @Binding var events: [HealthEvent]
    @State private var title = ""
    @State private var description = ""
    @State private var date = Date()
    @State private var time = Date()
    @State private var venue = ""
    @State private var selectedImage: UIImage? = nil
    @State private var isShowingImagePicker = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Event Details")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                    TextField("Venue", text: $venue)
                    
                    DatePicker("Date", selection: $date, in: Date()..., displayedComponents: .date)
                    DatePicker("Time", selection: $time, in: Date()..., displayedComponents: .hourAndMinute)
                }
                
                Section(header: Text("Add Picture")) {
                    Button(action: {
                        self.isShowingImagePicker = true
                    }) {
                        Text("Choose Picture")
                    }
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
                
                Section {
                    Button(action: {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateStyle = .medium
                        dateFormatter.timeStyle = .none
                        
                        let timeFormatter = DateFormatter()
                        timeFormatter.timeStyle = .short
                        
                        let newEvent = HealthEvent(title: title, description: description, date: dateFormatter.string(from: date), time: timeFormatter.string(from: time), venue: venue, imageName: "")
                        events.append(newEvent)
                    }) {
                        Text("Add Event")
                    }
                }
            }
            .navigationTitle("Add Health Event")
            .sheet(isPresented: $isShowingImagePicker) {
                ImagePicker(image: self.$selectedImage)
            }
        }
    }
}


struct AdminView: View {
    var body: some View {
        NavigationView {
            AdminEventsView(events: sampleHealthEvents)
                .navigationTitle("Admin Home")
        }
    }
}



struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
