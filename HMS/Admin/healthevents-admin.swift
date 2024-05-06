//
//  healthevents-admin.swift
//  HMS
//
//  Created by Protyush Kundu on 30/04/24.
//


import SwiftUI



struct AdminEventsView: View {
    @State private var showAddEventSheet = false
    @StateObject private var viewModel = EventsViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.events) { event in
                NavigationLink(destination: EmptyView()) {
                    VStack(alignment: .leading) {
                        Image(systemName: "photo") // Placeholder image until you resolve the issue
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 150)
                            .clipped()
                            .cornerRadius(10)
                        
                        Text(event.title)
                            .font(.headline)
                        Text("\(event.date) - \(event.time)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .swipeActions {
                    Button(role: .destructive) {
                        viewModel.deleteEvent(eventId: event.id)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
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
                AddEventView()
            }
            .task {
                try? await viewModel.getAllEvents()
            }
            .refreshable {
                try? await viewModel.getAllEvents()
            }
        }
    }
}

struct AddEventView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var startTime = Date()
    @State private var venue = ""
    @State private var selectedImage: UIImage? = nil
    @State private var isShowingImagePicker = false
    let healthEventsManager = HealthEventsManager.shared
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Event Details")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                    TextField("Venue", text: $venue)
                    DatePicker("Date and Time", selection: $startTime, displayedComponents: [.date, .hourAndMinute])
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
                        
                        let newEvent = HealthEvent(id: UUID().uuidString, title: title, description: description, date: dateFormatter.string(from: startTime), time: timeFormatter.string(from: startTime), venue: venue, imageName: "") // Provide a placeholder value for imageName
                        healthEventsManager.addHealthEvent(newEvent)
                        
                        // Call the function here addHeathEvents
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

#Preview {
    AdminEventsView()
}
