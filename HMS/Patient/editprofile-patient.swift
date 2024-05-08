//import SwiftUI
//
//struct EditProfileView: View {
//    @Binding var patient: PatientModel
//    @State private var heightText: String?
//    @State private var weightText: String?
//    @State private var selectedGenderIndex = 0
//    
//    // Define blood group options
//    let bloodGroupOptions = PatientModel.BloodGroup.allCases
//    
//    // Define gender options
//    let genderOptions = PatientModel.Gender.allCases
//    
//    var body: some View {
//        VStack {
//            Text("Edit Profile")
//                .font(.title)
//                .fontWeight(.bold)
//                .padding(.bottom, 30)
//            
//            // Form fields for editing patient details
//            EditTextField(label: "Name", value: $patient.name)
//            EditTextField(label: "Height", value: $heightText)
//            EditTextField(label: "Weight", value: $weightText)
//            
//            EditPickerField(label: "Blood Group", options: bloodGroupOptions, selection: $patient.bloodGroup)
//            
//            EditTextField(label: "Address", value: $patient.address)
//            EditTextField(label: "Contact", value: $patient.contact)
//            EditTextField(label: "Email", value: $patient.email)
//            EditTextField(label: "Emergency Contact", value: $patient.emergencyContact)
//            
//            EditPickerField(label: "Gender", options: genderOptions, selection: $patient.gender)
//            
//            Spacer()
//        }
//        .padding()
//    }
//}
//
//// Reusable text field component
//struct EditTextField: View {
//    let label: String
//    @Binding var value: String?
//    
//    var body: some View {
//        TextField(label, text: $value ?? "")
//            .textFieldStyle(RoundedBorderTextFieldStyle())
//            .padding()
//    }
//}
//
//// Reusable picker field component
//struct EditPickerField<T: Equatable>: View {
//    let label: String
//    let options: [T]
//    @Binding var selection: T?
//    
//    var body: some View {
//        Picker(label, selection: $selection) {
//            ForEach(options, id: \.self) { option in
//                Text("\(option)")
//            }
//        }
//        .pickerStyle(SegmentedPickerStyle())
//        .padding()
//    }
//}
//
//// Preview
//struct EditProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        let samplePatient = PatientModel(id: "1", name: "John Doe", height: 175.0, weight: 70.0, bloodGroup: .APositive, address: "123 Main St", contact: "1234567890", email: "john@example.com", emergencyContact: "0987654321", gender: .male)
//        return EditProfileView(patient: .constant(samplePatient))
//    }
//}
