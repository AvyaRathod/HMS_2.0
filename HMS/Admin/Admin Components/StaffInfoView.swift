//
//  StaffInfoView.swift
//  HMS
//
//  Created by Vishnu on 25/04/24.
//

import SwiftUI

struct StaffInfoView: View {
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(filteredStaff()) { staff in
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .font(.largeTitle)
                                .padding(.trailing)
                            VStack(alignment: .leading) {
                                Text(staff.name)
                                    .fontWeight(.bold)
                                Text(staff.spec)
                                    .foregroundColor(.gray)
                                Text("Employee Id: \(staff.id)")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .searchable(text: $searchText)
            }
            .navigationTitle("Staff info")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: DAddView(), label: {
                        Image(systemName: "plus")
                            .font(.title)
                    })
                }
            }
        }
    }

    
    private func filteredStaff() -> [Staff] {
        if searchText.isEmpty {
            return staffData
        } else {
            return staffData.filter { staff in
                staff.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

struct Staff: Identifiable {
    let id: Int
    let name: String
    let spec: String
}


let staffData = [
    Staff(id: 20, name: "Dr. Newton", spec: "Cardiologist"),
    Staff(id: 21, name: "Dr. Sunil", spec: "Orthopedic"),
    Staff(id: 22, name: "Dr. Kasyap", spec: "Hematologist"),
    Staff(id: 23, name: "Dr. Raghu", spec: "Pediatrician"),
    Staff(id: 24, name: "Dr. Adam", spec: "Pulmonologist"),
    Staff(id: 25, name: "Dr. Ramaswamy", spec: "Urologist"),
]

#Preview {
    StaffInfoView()
}
