//
//  DLeaveApp.swift
//  HMS
//
//  Created by Avya Rathod on 07/05/24.
//

import SwiftUI

enum SearchOptions{
    case dates
    case reason
    case timeslots
}

struct DLeaveAppView: View {
    @State private var selectedOption: SearchOptions = .dates
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var startTime = Date()
    @State private var endTime = Date()
    
    var body: some View {
        //search menu
        VStack{
            Spacer()
            Text("Leave Application")
                .font(.title)
                .fontWeight (.semibold)
            Spacer()
            VStack(alignment: .leading) {
                if selectedOption == .dates {
                    Text("When do you want to take a leave?")
                        .font (.title2)
                        .fontWeight (.semibold)
                    VStack {
                        HStack {
                            DatePicker ("From", selection: $startDate, displayedComponents:.date)
                            DatePicker ("From-time", selection: $startTime, displayedComponents:.hourAndMinute).labelsHidden()
                        }
                        Divider()
                        HStack{
                            DatePicker("To", selection: $endDate, displayedComponents: .date)
                            DatePicker ("From-time", selection: $endTime, displayedComponents:.hourAndMinute).labelsHidden()
                        }
                    }
                }else{
                    CollapsedPickerView(title: "When", description: "Add dates")
                }
            }
            .padding()
            .frame(height: selectedOption == .dates ? 160 : 64)
            .background (.white)
            .clipShape (RoundedRectangle (cornerRadius: 12))
            .padding()
            .shadow(radius: 10)
            .onTapGesture {
                withAnimation(.snappy) { selectedOption = .dates }
            }
            
            VStack(alignment: .leading) {
                if selectedOption == .reason {
                    Text("Why are you taking a leave?")
                        .font (.title2)
                        .fontWeight (.semibold)
                    
                    
                    }
                else{
                    CollapsedPickerView(title: "Reason?", description: "Add reason")
                }
            }
            .padding()
            .frame(height: selectedOption == .reason ? 270 : 64)
            .background (.white)
            .clipShape (RoundedRectangle (cornerRadius: 12))
            .padding()
            .shadow(radius: 10)
            .onTapGesture {
                withAnimation(.snappy) { selectedOption = .reason }
            }
            
            Spacer()
        }
        .offset(y:-60)
    }
}

struct ServiceIconView: View {
    var serviceName: String
    var imageName: String

    var body: some View {
        VStack {
            // Service Image Placeholder
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 70, height: 70)
                .foregroundColor(.gray)
            
            Text(serviceName)
                .font(.subheadline)
                .foregroundColor(.white)
        }
        .padding(10.0)
        .buttonStyle(PlainButtonStyle())
    }
}

struct CollapsedPickerView: View{
    let title: String
    let description: String
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .foregroundStyle(.gray)
                Spacer ()
                Text (description)
            }
                    .fontWeight(.semibold)
                    .font (.subheadline)
        }
    }
}
