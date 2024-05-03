import SwiftUI
import Firebase

struct StaffInfoView: View {
    @State private var searchText = ""
    @State private var staffData: [DoctorModel] = []
    @State private var isRefreshing = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(filteredStaff) { staff in
                        NavigationLink(destination: EmptyView()) {
                            HStack {
                                Image(systemName: "person.circle.fill")
                                    .font(.largeTitle)
                                    .padding(.trailing)
                                VStack(alignment: .leading) {
                                    Text(staff.name)
                                        .fontWeight(.bold)
                                    Text(staff.specialisation)
                                        .foregroundColor(.gray)
                                    Text("Employee Id: \(staff.employeeID)")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
                        Button("Flag") {
                            // Action to flag the item
                        }
                        .tint(.yellow)
                        
                        Button("Delete") {
                            // Action to delete the item
                        }
                        .tint(.red)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button("Archive") {
                            // Action to archive the item
                        }
                        .tint(.blue)
                    }
                }
                .searchable(text: $searchText)
                .refreshable {
                    await refreshData()
                }
                .navigationTitle("Staff info")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: DAddView(), label: {
                            Image(systemName: "plus")
                                .font(.title2)
                        })
                    }
                }
                .onAppear {
                    Task {
                        staffData = await fetchAllDoctors()
                    }
                }
            }
        }
    }
    
    private var filteredStaff: [DoctorModel] {
        if searchText.isEmpty {
            return staffData
        } else {
            return staffData.filter { staff in
                staff.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    private func refreshData() async {
        isRefreshing = true
        staffData = await fetchAllDoctors()
        isRefreshing = false
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

// Preview
struct StaffInfoView_Previews: PreviewProvider {
    static var previews: some View {
        StaffInfoView()
    }
}
