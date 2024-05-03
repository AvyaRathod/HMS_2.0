//
//  edit-profile.swift
//  HMS
//
//  Created by Protyush Kundu on 02/05/24.
//
import SwiftUI

struct EditProfileView: View {
    @Binding var patient: PatientDetails
    @State private var selectedAgeIndex = 0
    @State private var selectedGenderIndex = 0
    @Environment(\.presentationMode) var presentationMode
    
    // Generate an array of ages for the Picker
    let ages = Array(1...100)
    
    // Define gender options
    let genderOptions = ["Male", "Female", "Other"]
    
    var body: some View {
        VStack {
            Text("Edit Profile")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 30)
            
            // Form fields for editing patient details
            TextField("Name", text: $patient.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            // Age Section
            HStack {
                Text("Age:")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.leading, 10) // Adjusted padding
                
                // Age Picker
                Picker(selection: $selectedAgeIndex, label: Text("")) {
                    ForEach(0 ..< ages.count) {
                        Text("\(self.ages[$0])")
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding(.trailing, 10) // Adjusted padding
            }
            .padding(.horizontal, 20) // Adjusted horizontal padding
            
            // Gender Section
            HStack {
                Text("Gender:")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.leading, 10) // Adjusted padding
                
                // Gender Picker
                Picker(selection: $selectedGenderIndex, label: Text("")) {
                    ForEach(0 ..< genderOptions.count) {
                        Text("\(self.genderOptions[$0])")
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding(.trailing, 10) // Adjusted padding
            }
            .padding(.horizontal, 20) // Adjusted horizontal padding
            
            TextField("Email", text: $patient.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Address", text: $patient.address)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Phone Number", text: $patient.phoneNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            // Save button
            Button(action: {
                // Save the changes and dismiss the view
                saveChanges()
            }) {
                Text("Save")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
            }
            
            Spacer()
        }
        .padding()
    }
    
    func saveChanges() {
        // Update the patient's age and gender based on the selected indices
        patient.age = ages[selectedAgeIndex]
        patient.gender = genderOptions[selectedGenderIndex]
        
        // Perform save action here
        // For demonstration purposes, I'm just dismissing the view
        presentationMode.wrappedValue.dismiss()
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let patient = PatientDetails(name: "John Doe", id: "123456", age: 35, gender: "Male", email: "johndoe@example.com", address: "123 Main St, Anytown", phoneNumber: "555-1234")
        return EditProfileView(patient: .constant(patient))
    }
}
