//
//  healthevents-admin.swift
//  HMS
//
//  Created by Protyush Kundu on 30/04/24.
//


import SwiftUI

import FirebaseStorage

struct AdminEventsView: View {
    @State private var showAddEventSheet = false
    @StateObject private var viewModel = EventsViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.events) { event in
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
                    
                    Text("Attendees: \(event.attendees)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
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
    @State private var eventImage: String = ""
    @State private var isShowingImagePicker = false
    let healthEventsManager = HealthEventsManager.shared
    
    @State var isPickerShowing = false
    @State var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    
    var isFormComplete: Bool {
        !title.isEmpty && !description.isEmpty && !venue.isEmpty && selectedImage != nil
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Event Details")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                    TextField("Venue", text: $venue)
                    DatePicker("Date and Time", selection: $startTime, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                }

                Section(header: Text("Add Picture")) {
                    Button(action: {
                        self.isShowingImagePicker = true
                    }) {
                        Text("Choose Picture")
                    }
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .shadow(radius: 5)
                    }
                }

                Section {
                    Button(action: {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateStyle = .medium
                        dateFormatter.timeStyle = .none
                        
                        let timeFormatter = DateFormatter()
                        timeFormatter.timeStyle = .short
                        
                        uploadEventPhoto()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Add a delay to ensure the image is uploaded
                            let newEvent = HealthEvent(
                                id: UUID().uuidString,
                                title: title,
                                description: description,
                                date: dateFormatter.string(from: startTime),
                                time: timeFormatter.string(from: startTime),
                                venue: venue,
                                imageName: eventImage // Use eventImage here
                            )
                            healthEventsManager.addHealthEvent(newEvent)
                            showAlert = true // Show the alert after adding the event
                        }
                    }) {
                        Text("Add Event")
                    }
                    .disabled(!isFormComplete)
                }
            }
            .navigationTitle("Add Health Event")
            .sheet(isPresented: $isShowingImagePicker) {
                ImagePicker(image: self.$selectedImage)
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Success"),
                    message: Text("Event added successfully"),
                    dismissButton: .default(Text("OK")) {
                        presentationMode.wrappedValue.dismiss()// Navigate back to AddEventView
                        // You can use NavigationLink or popToRoot
                    }
                )
            }
        }
    }
    
    
    func uploadEventPhoto() {
        guard let selectedImage = selectedImage else {
            return
        }
        let storageRef = Storage.storage().reference()
        guard let imageData = selectedImage.jpegData(compressionQuality: 0.8) else {
            return
        }
        let path = "Events/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        let uploadTask = fileRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Error adding photo: \(error.localizedDescription)")
            } else {
                print("image added successfully")
                eventImage = path
            }
        }
    }
}




#Preview {
    AdminEventsView()
}
