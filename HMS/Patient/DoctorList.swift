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
    let Gender: String
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
struct DoctorListView: View {
    let doctors: [DoctorList] = [
        DoctorList(name: "Dr. Martin", description: "Cardiology", qualification: "MBBS,MD", experience: "2 Years", profileImageName: "DrMartinPhoto", Gender: "Male"),
        DoctorList(name: "Dr. Priya", description: "Cardiology", qualification: "MBBS,MD", experience: "10 Years", profileImageName: "DrPriyaPhoto", Gender: "Female"),
        DoctorList(name: "Dr. Vinod", description: "Cardiology", qualification: "MBBS,MD", experience: "5 Years", profileImageName: "DrVinodPhoto",Gender: "Male"),
        DoctorList(name: "Dr. ShamiliVarma", description: "Cardiology",qualification: "MBBS,MD", experience: "20 Years", profileImageName: "DrShamiliVarmaPhoto",Gender: "Female")
    ]
    @State private var isFiltering = false
    @State private var searchText = ""
    @State private var experienceFilter = 0
    
    var filteredDoctors: [DoctorList] {
            var filtered = doctors
            
            // Apply search text filter
            if !searchText.isEmpty {
                filtered = filtered.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            }
            
            // Apply experience filter
            if experienceFilter > 0 {
                filtered = filtered.filter { Int($0.experience.replacingOccurrences(of: " Years", with: "")) ?? 0 >= experienceFilter }
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
                Image(doctor.profileImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame( width: 110, height: 150, alignment: .leading)
                    .cornerRadius(10)
                
                
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
                        NavigationLink(destination: SlotBookView()) {
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
            
        }.frame(maxWidth: .infinity)
                .padding()
                .background(Color("doclist"))
                .cornerRadius(10)
                .shadow(radius: 5)
        
    
        

    }
}


struct DoctorListView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorListView()
    }
}
