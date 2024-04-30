//
//  DepartmentViewTab.swift
//  HMS
//
//  Created by Shashwat Singh and Pratiyush on 23/04/24.
//

import SwiftUI
import UIKit



// SwiftUI View to display hospital buttons
struct HospitalView: View {
    @State private var searchText = ""
    @State private var isSearching = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Search Bar
                SearchBarDept(text: $searchText, isSearching: $isSearching)
                    .padding(.top, 10)
                    .padding(.horizontal)
                
                // Departments Grid inside ScrollView
                ScrollView {
                    DepartmentsGridView(searchText: searchText)
                        .padding()
                }
                
                // Instructions Text
                Text("Tap a department to proceed")
                    .font(.headline)
                    .foregroundColor(.black)
            }
            .navigationBarTitle("Departments")
        }
    }
}

// SearchBar Component
struct SearchBarDept: View {
    @Binding var text: String
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            TextField("  Search departments", text: $text)
                .padding(.leading, 24)
                .padding(.vertical, 10)
                .padding(.trailing, 10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.leading, 8)
                        Spacer()
                        if isSearching {
                            Button(action: {
                                withAnimation {
                                    self.text = ""
                                    isSearching = false
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                }
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .onTapGesture {
                    isSearching = true
                }
            
            if isSearching {
                Button(action: {
                    withAnimation {
                        self.text = ""
                        isSearching = false
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }) {
                    Text("Cancel")
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 10)
            }
        }
        .padding(.horizontal)
        .navigationBarHidden(isSearching)
    }
}

// Departments Grid
struct DepartmentsGridView: View {
    let departments = [
          "Cardiology", "Neurology", "Orthopedics", "Pediatrics",
          "Dermatology", "Urology",
          "Endocrinology", "Rheumatology"
      ]
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    let searchText: String
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(departments.filter { searchText.isEmpty || $0.localizedCaseInsensitiveContains(searchText) }, id: \.self) { department in
                NavigationLink(destination: DepartmentDetailView(title: department)) {
                    Rectangle()
                        .frame(width: 160,height: 180)
                        .cornerRadius(15)
                        .foregroundColor(Color.white)
                        .shadow(radius: 2)
                        .overlay(
                            VStack{
                                Image(systemName: "")
                                    .frame(width: 70,height: 70)
                                    .background(.gray)
                                    .clipShape(Circle())
                                    .shadow(radius: 1)
                                    
                                Text(department)
                                    .font(.system(size: 22))
                                    .foregroundColor(.black)
                                    .bold()
                                Text("(280 Review)")
                                    .font(.system(size: 15))
                
                                HStack{
                                    Rectangle()
                                        .frame(width: 70,height: 23)
                                        .cornerRadius(15)
                                        .foregroundColor(Color.green.opacity(0.2))
                                        .shadow(radius: 1)
                                        .overlay(
                                            HStack(spacing:2){
                                                Image(systemName: "star.fill")
                                                    .foregroundColor(.green)
                                                Text("4.4")
                                                    .foregroundStyle(Color.green)
                                                    
                                            }
                                        )
                                }
                                .padding(.top,-5)
                            }
                        )
                }
                
            }
        }
    }
}

// Department Detail View
struct DepartmentDetailView: View {
    let title: String
    
    var body: some View {
        VStack {
            Text("Welcome to \(title)")
                .font(.title)
                .padding()
            
            Text("This is the \(title) department.")
                .font(.body)
                .padding()
            
            Spacer()
        }
        .navigationBarTitle(title)
    }
}

struct HospitalView_Previews: PreviewProvider {
    static var previews: some View {
        HospitalView()
    }
}

