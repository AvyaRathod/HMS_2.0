//
//  DoctorList.swift
//  HMS
//
//  Created by admin on 23/04/24.
//
import SwiftUI

struct DoctorList: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let qualification: String
    let experience: String
    let profileImageName: String
    
}

struct FilterExperienceView: View {
    @Binding var isFiltering: Bool
    @Binding var selectedExperienceRange: ClosedRange<Int>?
    

    
    @State private var isExperienceExpanded = false

    
    let experienceRanges: [ClosedRange<Int>] = [
        0...5,
        6...10,
        11...15,
        16...20
    ]
   
  
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Filter Options")
                    .font(.headline)
                    .padding()
                
                
                
                // Experience filter
                VStack {
                    Button(action: {
                        isExperienceExpanded.toggle()
                    }) {
                        HStack {
                            Text("Experience")
                            Spacer()
                            Image(systemName: isExperienceExpanded ? "chevron.up" : "chevron.down")
                        }
                        .padding()
                        .foregroundColor(.blue)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    }
                    if isExperienceExpanded {
                        Picker("Experience", selection: Binding<Int>(
                            get: {
                                if let selectedRange = selectedExperienceRange {
                                    return experienceRanges.firstIndex(where: { $0 == selectedRange }) ?? 0
                                } else {
                                    return 0
                                }
                            },
                            set: { index in
                                selectedExperienceRange = experienceRanges[index]
                            }
                        )) {
                            ForEach(experienceRanges.indices, id: \.self) { index in
                                Text("\(experienceRanges[index].lowerBound)-\(experienceRanges[index].upperBound) Years").tag(index)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                    }
                }
                
                
                Spacer()
                
                Button(action: {
                    // Apply filtering
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


struct DoctorListView: View {
    let doctors: [DoctorList] = [
        DoctorList(name: "Dr. Martin", description: "Cardiology", qualification: "MBBS,MD", experience: "2 Years", profileImageName: "DrMartinPhoto"),
        DoctorList(name: "Dr. Priya", description: "Cardiology", qualification: "MBBS,MD", experience: "10 Years", profileImageName: "DrPriyaPhoto"),
        DoctorList(name: "Dr. Vinod", description: "Cardiology", qualification: "MBBS,MD", experience: "5 Years", profileImageName: "DrVinodPhoto"),
        DoctorList(name: "Dr. ShamiliVarma", description: "Cardiology",qualification: "MBBS,MD", experience: "20 Years", profileImageName: "DrShamiliVarmaPhoto")
    ]
    @State private var isFiltering = false
    @State private var searchText = ""
    @State private var experienceFilter = 0
    @State private var selectedExperienceRange: ClosedRange<Int>? = nil
    @State private var selectedGenderIndex: Int? = nil
    
    let genders = ["Female", "Male"]

    
    
    var filteredDoctors: [DoctorList] {
        var filtered = doctors
        
        // Apply search text filter
        if !searchText.isEmpty {
            filtered = filtered.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
        
        // Apply experience filter
        if let selectedRange = selectedExperienceRange {
            filtered = filtered.filter { doctor in
                let experience = Int(doctor.experience.replacingOccurrences(of: " Years", with: "")) ?? 0
                return selectedRange.contains(experience)
            }
        }
        
        
        
        return filtered
    }



    var body: some View {
        NavigationView {
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
            .navigationBarItems(leading: clearFiltersButton,trailing:
                            Button(action: {
                                isFiltering = true // Show the filtering modal sheet when button is clicked
                            }) {
                                Image(systemName: "line.horizontal.3.decrease.circle")
                                    .imageScale(.large)
                            }
                .foregroundColor(.navy)
                        )
            .sheet(isPresented: $isFiltering) {
                            // Modal sheet for filtering based on experience
                            FilterExperienceView(isFiltering: $isFiltering, selectedExperienceRange: $selectedExperienceRange)
                        }
        }
    }
    private var clearFiltersButton: some View {
            Button("Clear Filters") {
                // Clear all filters
                searchText = ""
                selectedExperienceRange = nil
                // Add more filter variables if needed
            }
            .foregroundColor(.navy)
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


struct DoctorCardView: View {
    let doctor: DoctorList
    @State private var isFavorite = false
    @State private var showBookButton = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack{
//                AsyncImage(url: URL(string: "https://miro.medium.com/v2/resize:fit:1400/format:webp/1*R8hYX5NIfWu6sBfobj4f3A.jpeg")) { image in
//                            image
//                                .resizable()
//                                .aspectRatio(contentMode: .fill)
//                                .frame( width: 110, height: 150, alignment: .leading)
//                                .cornerRadius(10)
//                        } placeholder: {
//                            ProgressView()
//                        }
                Image(doctor.profileImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame( width: 110, height: 150, alignment: .leading)
                    .cornerRadius(10)
                    
                Spacer()
                VStack(alignment: .leading){
                    HStack{
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
                        
                    HStack{
                        Text(doctor.description)
                            .font(.system(size: 15))
                            .foregroundColor(.gray)
                        Text("|")
                            .font(.system(size: 15))
                            .foregroundColor(.gray)
                        Text(doctor.qualification)
                            .font(.system(size: 15))
                            .foregroundColor(.gray)
                    }
                    Text(doctor.experience)
                        .font(.system(size: 14, weight: .semibold))
                    
                        
                        
                    HStack{
                        Spacer()
                        if showBookButton {
                            Button(action: {
                                // Book appointment action
                            }) {
                                Text("Book")
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .background(Color.navy)
                                    .cornerRadius(8)
                            }
                        }
                        
                        
                        
                        
                           
                    }
                }
            }

        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.blueShade.opacity(0.1))
        .cornerRadius(10)
        
        

    }
}


struct DoctorListView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorListView()
    }
}
