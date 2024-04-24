//
//  PdetailView.swift
//  HMS
//
//  Created by Sarthak on 23/04/24.
//

import SwiftUI

struct PdetailView: View {
  @State private var fullName = ""
  @State private var gender = ""
  @State private var DOB = ""
  @State private var height = ""
  @State private var weight = ""
  @State private var bloodGroup = ""
  @State private var address = ""
  @State private var emgContact = ""
//  let fullName: String?
   
  var body: some View {
    NavigationStack{
      ScrollView{
        VStack{
          Text("Enter Details")
           .font(.largeTitle)
           .padding(.bottom)
           .bold()
//          Text(fullName!) // Display the passed fullName
//                .padding(.bottom)
          ZStack {
           TextField("", text: $fullName)
            .padding(.horizontal, 10)
            .frame(width: 360, height: 52)
            .overlay(
             RoundedRectangle(cornerSize: CGSize(width: 4, height: 4))
              .stroke(Color.gray, lineWidth: 1)
            )
           HStack {
            Text("Full Name")
             .font(.headline)
             .fontWeight(.medium)
             .foregroundColor(Color.black)
             .multilineTextAlignment(.leading)
             .padding(.bottom, 2)
             .background(Color(Color.white))
            Spacer()
           }
           .padding(.leading, 18)
           .offset(CGSize(width: 0, height: -25))
          }.padding(.top, 1)
           
          InputFieldView(data: $gender, title: "Gender")
          InputFieldView(data: $DOB, title: "Date Of Birth")
          InputFieldView(data: $height, title: "Height")
          InputFieldView(data: $weight, title: "Weight")
          InputFieldView(data: $bloodGroup, title: "Blood Group")
          InputFieldView(data: $address, title: "Address")
          InputFieldView(data: $emgContact, title: "Emergency Contact")
           
          NavigationLink {
              PatientHomeScreen().navigationBarBackButtonHidden()
           // Home View
          } label: {
           Text("Continue")
            .fontWeight(.heavy)
            .font(.title3)
            .frame(width: 300)
            .padding()
            .foregroundColor(.white)
            .background(Color(Color.black))
            .cornerRadius(40)
          }
           
        }.padding(.top,60)
      }
    }
  }
}

#Preview {
  PdetailView()
}
