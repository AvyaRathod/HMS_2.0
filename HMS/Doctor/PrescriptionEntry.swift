//
//  PrescriptionEntry.swift
//  HMS
//
//  Created by admin on 30/04/24.
//

//
//  PrescriptionEntry.swift
//  HMS
//
//  Created by admin on 29/04/24.
//

import SwiftUI

struct PrescriptionModel: Codable, Identifiable {
    var  id = UUID()
    let doctorId: String
    let patentId: String
    var patientName: String
    var patientStatus: String
    var description: String
    var referedDoctorId: String
    var prescribedMedicines: [String : [String]]
    var prescribedTest: [String]
    
//    init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.doctorId = try container.decode(String.self, forKey: .doctorId)
//        self.patentId = try container.decode(String.self, forKey: .patentId)
//        self.patientName = try container.decode(String.self, forKey: .patientName)
//        self.patientStatus = try container.decode(String.self, forKey: .patientStatus)
//        self.description = try container.decode(String.self, forKey: .description)
//        self.referedDoctorId = try container.decode(String.self, forKey: .referedDoctorId)
//        self.prescribedMedicines = try container.decode([String : String].self, forKey: .prescribedMedicines)
//        self.prescribedTest = try container.decode([String].self, forKey: .prescribedTest)
//    }
    
    
    
    func getDictionary() -> [String:Any]{
        return [
            "id": id,
            "doctorId": doctorId,
            "patientId": patentId,
            "patientName": patientName,
            "description": description,
            "referedDoctorId": referedDoctorId,
            "prescribedMedicines": prescribedMedicines,
            "prescribedTest": prescribedTest
        ]
    }
}

struct PrescriptionEntryView: View {
    @State private var patientName = ""
    @State private var patientStatus = ""
    @State private var description = ""
    @State private var referredDoctorId = ""
    @State private var medicines: [String] = []
    @State private var dosages: [String] = []
    @State private var prescribedTest: [String] = []
    @State private var selectedTimes: [[Bool]] = Array(repeating: Array(repeating: false, count: 3), count: 10)
    @State private var selectedFoodOptions: [[Int]] = Array(repeating: Array(repeating: -1, count: 1), count: 10)

    
    let times = ["Morning", "Afternoon", "Night"]
    let foodOptions = ["Before Food", "After Food"]

    var body: some View {
        
        NavigationView {
           
                Form {
                    
                    Section(header: Text("Prescription Details")) {
                    
                            TextField("Patient Name", text: $patientName)

                        
                    }
                    Section(header: Text("Description")) {
                        TextField("Patient Condition", text: $patientStatus)
                        TextEditor(text: $description)
                    }
                    
                    
                    Section(header: Text("Prescribed Medicines")) {
                        ForEach(0..<medicines.count, id: \.self) { index in
                            HStack {
                                TextField("Medicine", text: $medicines[index])
                                    .frame(width: 200)
                                TextField("Dosage", text: $dosages[index])
                                
                                Button(action: {
                                    removeMedicine(at: index)
                                }) {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.red)
                                }
                            }
                            HStack {
                                ForEach(times.indices, id: \.self) { timeIndex in
                                    CheckboxField(
                                        title: times[timeIndex],
                                        isSelected: $selectedTimes[index][timeIndex]
                                    )
                                }
                            }
                            HStack {
                                                                ForEach(foodOptions.indices, id: \.self) { optionIndex in
                                                                    CheckboxField(
                                                                        title: foodOptions[optionIndex],
                                                                        isSelected: Binding(
                                                                            get: { selectedFoodOptions[index][0] == optionIndex },
                                                                            set: { newValue in
                                                                                selectedFoodOptions[index][0] = newValue ? optionIndex : -1
                                                                            }
                                                                        )
                                                                    )
                                                                }
                                                            }
                        }
                        
                        Button(action: {
                            self.medicines.append("")
                            self.dosages.append("")
                        }) {
                            Text("Add Medicine")
                        }
                    }
                    Section(header: Text("Prescribed Tests")) {
                        ForEach(prescribedTest.indices, id: \.self) { index in
                            HStack {
                                TextField("Test", text: $prescribedTest[index])
                                Button(action: {
                                    removeTest(at: index)
                                }) {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        Button(action: {
                            self.prescribedTest.append("")
                        }) {
                            Text("Add Test")
                        }
                    }
                    Section(header: Text("Refferals")){
                        VStack{
                            
                            TextField("Referrals", text: $referredDoctorId)
                        }
                    }
                
                    Section {
                        HStack{
                            Spacer()
                            Button("Submit") {
                                // Submit prescription
                                submitPrescription()
                               
                            }
                            Spacer()
                        }
                    }
                                
                
               
            }
            .navigationTitle("Prescription")
//            .background(Color.clear)
        }
    }
    
    func addMedicine() {
            medicines.append("")
            dosages.append("")
            selectedTimes.append(Array(repeating: false, count: 3))
        selectedFoodOptions.append(Array(repeating: -1, count: 1))
        }

    func removeMedicine(at index: Int) {
            medicines.remove(at: index)
            dosages.remove(at: index)
            selectedTimes.remove(at: index)
        selectedFoodOptions.remove(at: index)

        }
    func removeTest(at index: Int) {
            prescribedTest.remove(at: index)
        }

    struct CheckboxField: View {
        let title: String
        @Binding var isSelected: Bool

        var body: some View {
            Button {
                isSelected.toggle()
            } label: {
                HStack {
                    Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                        .foregroundColor(isSelected ? .blue : .gray)
                    Text(title)
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
    func submitPrescription() {
                // Construct PrescriptionModel
                var prescribedMedicinesDictionary = [String: [String]]()
                for (index, medicine) in medicines.enumerated() {
                    var timesAndFoodOptions: [String] = []
                    for timeIndex in times.indices {
                        if selectedTimes[index][timeIndex] {
                            timesAndFoodOptions.append(times[timeIndex])
                        }
                    }
                    let selectedOptionIndex = selectedFoodOptions[index][0]
                    if selectedOptionIndex != -1 {
                        timesAndFoodOptions.append(foodOptions[selectedOptionIndex])
                    }
                    prescribedMedicinesDictionary[medicine] = timesAndFoodOptions
                }
                print(prescribedMedicinesDictionary)
            
        
        let newPrescription = PrescriptionModel(doctorId: "", patentId: "", patientName: patientName, patientStatus: patientStatus, description: description, referedDoctorId: referredDoctorId, prescribedMedicines: prescribedMedicinesDictionary, prescribedTest: prescribedTest)
        print(newPrescription.getDictionary())
            // Create PrescriptionModel instance
//            let prescriptionModel = PrescriptionModel(
//                doctorId: "doctor_id",
//                patentId: "patient_id",
//                patientName: patientName,
//                patientStatus: patientStatus,
//                description: description,
//                referedDoctorId: referredDoctorId,
//                prescribedMedicines: prescribedMedicinesDictionary, // Modify this with the created dictionary
//                prescribedTest: prescribedTest // Add prescribed tests here if needed
//            )
//
//             //Print or save prescription model
//            print(prescriptionModel)
        }
    
}

struct PrescriptionEntryView_Previews: PreviewProvider {
    static var previews: some View {
        PrescriptionEntryView()
    }
}
