import SwiftUI
import Firebase

struct DoctorListView: View {
    @State private var isFiltering = false
    @State private var searchText = ""
    @State private var experienceFilter = 0
    
    @State var doctors: [DoctorModel] = []

    var filteredDoctors: [DoctorModel] {
        var filtered = doctors
        
        // Apply search text filter
        if !searchText.isEmpty {
            filtered = filtered.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
        
        // Apply experience filter
        if experienceFilter > 0 {
            filtered = filtered.filter { Int($0.experience) ?? 0 >= experienceFilter }
        }
        
        return filtered
    }

    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(text: $searchText)
                    .padding(.horizontal)
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(filteredDoctors) { doctor in
                            DoctorCardView(doctor: doctor)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("All Doctors")
            .navigationBarItems(trailing:
                Button(action: {
                    isFiltering = true // Show the filtering modal sheet when button is clicked
                }) {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                        .imageScale(.large)
                }
            )
            .sheet(isPresented: $isFiltering) {
                // Modal sheet for filtering based on experience
                FilterExperienceView(isFiltering: $isFiltering, selectedExperience: $experienceFilter)
            }
        }
        .onAppear {
            Task {
                doctors = await fetchAllDoctors()
            }
        }
    }

    func fetchAllDoctors() async -> [DoctorModel] {
        let db = Firestore.firestore()
        do {
            let querySnapshot = try await db.collection("doctors").getDocuments()
            var doctors: [DoctorModel] = []
            for document in querySnapshot.documents {
                let data = document.data()
                let doctor = DoctorModel(from: data, id: document.documentID)
                doctors.append(doctor)
            }
            return doctors
        } catch {
            print("Error fetching doctors: \(error.localizedDescription)")
            return []
        }
    }
}

struct DoctorCardView: View {
    let doctor: DoctorModel
    @State private var isFavorite = false
    @State private var showBookButton = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack{
                // Replace this with an actual image view if your DoctorModel includes image URLs
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 110, height: 150, alignment: .leading)
                    .cornerRadius(10)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(doctor.name)
                            .font(.system(size: 20, weight: .bold))
                        Spacer()
                        if showBookButton {
                            Button(action: {
                                isFavorite.toggle()
                            }) {
                                Image(systemName: isFavorite ? "heart.fill" : "heart")
                                    .foregroundColor(isFavorite ? .red : .gray)
                            }
                        }
                    }
                    
                    Text(doctor.specialisation)
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                    
                    Text("\(doctor.experience) Years")
                        .font(.system(size: 14, weight: .semibold))
                    
                    Spacer()
                    NavigationLink(destination: SlotBookView(doctor:doctor)) {
                        Text("Book")
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color.blue)
                            .cornerRadius(30)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
//        .shadow(radius: 5)
    }
}

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search a Doctor", text: $text)
                .padding(.horizontal, 10)
                .padding(.vertical, 8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            Button(action: {
                self.text = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .padding(.trailing, 10)
            }
        }
    }
}

struct FilterExperienceView: View {
    @Binding var isFiltering: Bool
    @Binding var selectedExperience: Int

    var body: some View {
        NavigationView {
            VStack {
                Text("Filter Based on Experience")
                    .font(.headline)
                    .padding()
                Stepper(value: $selectedExperience, in: 0...50, step: 1) {
                    Text("Years of Experience: \(selectedExperience)")
                }
                .padding()

                Spacer()

                Button(action: {
                    // Apply filtering based on selected years of experience
                    // Here you can filter the doctors based on selectedExperience
                    // For demonstration, we just dismiss the modal sheet
                    isFiltering = false
                }) {
                    Text("Apply Filter")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Filter")
            .navigationBarItems(trailing:
                Button("Close") {
                    isFiltering = false // Close the modal sheet
                }
            )
        }
    }
}



// Update the preview provider if necessary
struct DoctorListView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorListView()
    }
}

// The SearchBar view remains unchanged, as it's just a UI element.
// ...
