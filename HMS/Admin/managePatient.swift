//
//  Manage.swift
//  HMS
//
//  Created by Avya Rathod on 08/05/24.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct managePatient: View {
    @State private var searchText = ""
    @State private var patientData: [PatientModel] = []
    @State private var isRefreshing = false

    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(text: $searchText, placeHolder: "Search Patient")
                    .padding(.leading, 20)

                List {
                    ForEach(filteredPatients(), id: \.id) { pat in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(pat.name ?? "Unknown Name")
                                    .fontWeight(.bold)
                                Text("Emergency Contact: \(pat.emergencyContact ?? "Unknown Contact")")
                                    .foregroundColor(.gray)
                                Text("ID: \(pat.id ?? "N/A")")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button("Delete") {
                            // Action to delete the item
                        }
                        .tint(.red)
                    }
                }
                .refreshable {
                    await refreshData()
                }
                .navigationTitle("Manage Admission")
            }
            .onAppear {
                Task {
                    patientData = await fetchAdmittedPatients()
                }
            }
        }
    }

    private func filteredPatients() -> [PatientModel] {
        guard !searchText.isEmpty else { return patientData }
        return patientData.filter { $0.name?.lowercased().contains(searchText.lowercased()) ?? false }
    }

    private func refreshData() async {
        isRefreshing = true
        patientData = await fetchAdmittedPatients()
        isRefreshing = false
    }

    func fetchAdmittedPatients() async -> [PatientModel] {
        let db = Firestore.firestore()
        do {
            let querySnapshot = try await db.collection("Patients").getDocuments()
            var patients: [PatientModel] = []
            for document in querySnapshot.documents {
                if let patient = PatientModel(dictionary: document.data(), id: document.documentID) {
                    patients.append(patient)
                }
            }
            return patients
        } catch {
            print("Error fetching patients: \(error.localizedDescription)")
            return []
        }
    }
}

#Preview {
    managePatient()
}
