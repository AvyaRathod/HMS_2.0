//
//  PdetailView.swift
//  HMS
//
//  Created by Sarthak on 23/04/24.
//

import SwiftUI

struct PdetailView: View {
    var title: String?
  @State private var gender = ""
  @State private var DOB = ""
  @State private var height = ""
  @State private var weight = ""
  @State private var bloodGroup = ""
  @State private var address = ""
  @State private var emgContact = ""
  @State private var patientGenderIndex = 0
    
    
    
//  let fullName: String?
    let genders: [PatientModel.Gender] = [
        .male,.female,.others
    ]
    let bloods: [PatientModel.BloodGroup] = [
        .ABNegative,.ABPositive,.ANegative,.APositive,.BNegative,.BPositive,.ONegative,.OPositive
    ]
  var body: some View {
    NavigationStack{
      ScrollView{
        VStack{
          Text("Enter Details")
           .font(.largeTitle)
           .padding(.bottom)
           .bold()
           
            ZStack {
                Picker("Gender", selection: $patientGenderIndex) {
                    ForEach(0..<genders.count) { index in
                        Text(genders[index].rawValue)
                        
                    }
                }
                .accentColor(.black)
                .pickerStyle(DefaultPickerStyle())
                .frame(width: 360, height: 52) // Set frame size to match InputFieldView
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.gray, lineWidth: 1)
                )
                HStack {
                    Text("Gender")
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 4)
                        .background(Color.white)
                    Spacer()
                }
                .padding(.leading, 18)
                .offset(y: -25)
            }
            .padding(4)


                        
            ZStack {
                Picker("BloodType", selection: $patientGenderIndex) {
                    ForEach(0..<bloods.count) { index in
                        Text(bloods[index].rawValue)
                        
                    }
                }
                .accentColor(.black)
                .pickerStyle(DefaultPickerStyle())
                .frame(width: 360, height: 52) // Set frame size to match InputFieldView
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.gray, lineWidth: 1)
                )
                HStack {
                    Text("Blood Group")
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 4)
                        .background(Color.white)
                    Spacer()
                }
                .padding(.leading, 18)
                .offset(y: -25)
            }
            .padding(4)
            
            
            ZStack {
                HStack {
                    TextField("Height", text: $height)
                        .keyboardType(.decimalPad)
                    Text("cm")
                }
                
              .padding(.horizontal, 10)
              .frame(width: 360, height: 52)
              .overlay(
               RoundedRectangle(cornerSize: CGSize(width: 4, height: 4))
                 .stroke(Color.gray, lineWidth: 1)
              )
             HStack {
              Text(title ?? "Height")
               .font(.headline)
               .fontWeight(.medium)
               .foregroundColor(Color.black)
               .multilineTextAlignment(.leading)
               .padding(.bottom,4)
               .background(Color(Color.white))
              Spacer()
             }
             .padding(.leading, 18)
             .offset(CGSize(width: 0, height: -25))
            }.padding(4)
            
            
            ZStack {
                HStack {
                    TextField("Weight", text: $weight)
                        .keyboardType(.decimalPad)
                    Text("kgs")
                }
              .padding(.horizontal, 10)
              .frame(width: 360, height: 52)
              .overlay(
               RoundedRectangle(cornerSize: CGSize(width: 4, height: 4))
                 .stroke(Color.gray, lineWidth: 1)
              )
             HStack {
              Text(title ?? "Weight")
               .font(.headline)
               .fontWeight(.medium)
               .foregroundColor(Color.black)
               .multilineTextAlignment(.leading)
               .padding(.bottom,4)
               .background(Color(Color.white))
              Spacer()
             }
             .padding(.leading, 18)
             .offset(CGSize(width: 0, height: -25))
            }.padding(4)
            
            
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
