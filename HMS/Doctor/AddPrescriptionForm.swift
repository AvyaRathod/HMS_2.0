//
//  AddPrescriptionForm.swift
//  HMS
//
//  Created by Vishnu on 29/04/24.
//

import SwiftUI

@MainActor
final class PrescriptionViewModel: ObservableObject {
    func addPatientRecord(patientId: String, prescriptionData: PrescriptionModel) {
        PrescriptionManager.shared.addPatientRecord(patientId: patientId, prescriptionData: prescriptionData)
    }
}


struct AddPrescriptionForm: View {
    @State private var doctorId = ""
    @State private var patientId = ""
    @State private var prescription = ""
    @State private var description = ""
    @State private var referedDoctorId = ""
    @State private var medicines: [MedicineDetail] = []
    @State private var medicineName = ""
    @State private var dosage = ""
    @State private var intakeMorning = false
    @State private var intakeAfternoon = false
    @State private var intakeNight = false
    @State private var beforeFood = false
    
    @StateObject private var viewModel = PrescriptionViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Doctor Details")) {
                    TextField("Doctor ID", text: $doctorId)
                    TextField("Patient ID", text: $patientId)
                }
                
                Section(header: Text("Prescription Details")) {
                    Text("Prescription")
                    TextEditor(text: $description)
                            .foregroundColor(.black)
                            .frame(minHeight: 100)

                    TextField("Description", text: $description)
                    TextField("Referred Doctor ID", text: $referedDoctorId)
                                    }
                
                Section(header: Text("Medicine Details")) {
                    ForEach(medicines.indices, id: \.self) { index in
                        MedicineRow(medicineDetail: $medicines[index])
                    }
                    Button("Add Medicine") {
                        addMedicine()
                    }
                }
                
                Section {
                    HStack {
                        Spacer() // Add spacer to push the button to the center
                        Button("Add Prescription") {
                            addPrescription()
                        }
                        .fontWeight(.bold)
                        .padding()
                        .background(.blue)
                        .foregroundColor(.primary)
                        .cornerRadius(3.0)
                        .frame(width: 900 , height: 40)
                        Spacer() // Add another spacer to center the button
                    }
                }
            }
            .navigationTitle("Prescription")
        }
    }
    
    func addMedicine() {
        let medicineDetail = MedicineDetail(
            name: medicineName,
            dosage: dosage,
            intakeMorning: intakeMorning,
            intakeAfternoon: intakeAfternoon,
            intakeNight: intakeNight,
            beforeFood: beforeFood
        )
        medicines.append(medicineDetail)
        
        // Clear input fields
        medicineName = ""
        dosage = ""
        intakeMorning = false
        intakeAfternoon = false
        intakeNight = false
        beforeFood = false
    }
    
    func addPrescription() {
        let prescribedMedicines = medicines.reduce(into: [String: PrescriptionModel.MedicineDetails]()) { result, medicine in
            result[medicine.name] = PrescriptionModel.MedicineDetails(
                dosage: medicine.dosage,
                intakePattern: medicine.getIntakePattern(),
                beforeFood: medicine.beforeFood
            )
        }
        
        let prescriptionData = PrescriptionModel(
            doctorId: doctorId,
            patentId: patientId,
            prescription: prescription,
            description: description,
            referedDoctorId: referedDoctorId,
            prescribedMedicines: prescribedMedicines
        )

        viewModel.addPatientRecord(patientId: patientId, prescriptionData: prescriptionData)
    }
}

struct MedicineRow: View {
    @Binding var medicineDetail: MedicineDetail
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Medicine Name", text: $medicineDetail.name)
            TextField("Dosage", text: $medicineDetail.dosage)
            Toggle("Morning", isOn: $medicineDetail.intakeMorning)
            Toggle("Afternoon", isOn: $medicineDetail.intakeAfternoon)
            Toggle("Night", isOn: $medicineDetail.intakeNight)
            Toggle("Before Food", isOn: $medicineDetail.beforeFood)
        }
    }
}

struct MedicineDetail {
    var name: String = ""
    var dosage: String = ""
    var intakeMorning: Bool = false
    var intakeAfternoon: Bool = false
    var intakeNight: Bool = false
    var beforeFood: Bool = false
    
    func getIntakePattern() -> [PrescriptionModel.IntakeTime] {
        var pattern: [PrescriptionModel.IntakeTime] = []
        if intakeMorning { pattern.append(.morning) }
        if intakeAfternoon { pattern.append(.afternoon) }
        if intakeNight { pattern.append(.night) }
        return pattern
    }
}


#Preview {
    AddPrescriptionForm()
}
