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
    @State private var patientStatus = ""
    @State private var description = ""
    @State private var referedDoctorId = ""
    @State private var medicines: [MedicineDetail] = []
    @State private var medicineName = ""
    @State private var dosage = ""
    @State private var intakeMorning = false
    @State private var intakeAfternoon = false
    @State private var intakeNight = false
    @State private var beforeFood = false
    @State private var afterFood = false
    @State private var prescribedTest = ""
    
    @StateObject private var viewModel = PrescriptionViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Doctor Details")) {
                    TextField("Doctor ID", text: $doctorId)
                    TextField("Patient ID", text: $patientId)
                }
                
                Section(header: Text("Prescription Details")) {
                    TextField("Patient Condition", text: $patientStatus)
                    TextEditor(text: $description)
                        .foregroundColor(.black)
                        .frame(minHeight: 100)
                    
                    
                    
                }
                Section(header: Text("Medicine")) {
                    ForEach(medicines.indices, id: \.self) { index in
                        MedicineRow(medicineDetail: $medicines[index]) {
                            removeMedicine(at: index)
                        }
                    }

                    Button("Add Medicine") {
                        addMedicine()
                    }
                }
                Section(header: Text("Prescribed Tests")) {
                    TextEditor(text: $prescribedTest)
                }
                    TextField("Referred Doctor ID", text: $referedDoctorId)
                                    
                
                Section {
                    HStack {
                        Spacer() // Add spacer to push the button to the center
                        Button("Add Prescription") {
                            addPrescription()
                        }
                        .fontWeight(.bold)
                        .padding()
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
    
    func removeMedicine(at index: Int) {
            medicines.remove(at: index)
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
                beforeFood: medicine.beforeFood,
                afterFood: medicine.afterFood
            )
        }
        
        let prescriptionData = PrescriptionModel(
            doctorId: doctorId,
            patentId: patientId,
            prescription: "",
            patientStatus: patientStatus,
            description: description,
            referedDoctorId: referedDoctorId,
            prescribedMedicines: prescribedMedicines
        )

        viewModel.addPatientRecord(patientId: patientId, prescriptionData: prescriptionData)
    }
    
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

struct MedicineRow: View {
    @Binding var medicineDetail: MedicineDetail
    var removeAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                TextField("Medicine Name", text: $medicineDetail.name)
                TextField("Dosage", text: $medicineDetail.dosage)
                Button(action: removeAction) {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.red)
                                }
                                           }
            
            HStack{
            CheckboxField(title: "Morning", isSelected: $medicineDetail.intakeMorning)
                CheckboxField(title: "Afternoon", isSelected: $medicineDetail.intakeAfternoon)
                CheckboxField(title: "Night", isSelected: $medicineDetail.intakeNight)
            }
            HStack{
                CheckboxField(title: "Before Food", isSelected: $medicineDetail.beforeFood)
                    .onChange(of: medicineDetail.beforeFood) { value in
                                            if value {
                                                medicineDetail.toggleBeforeAfterFood(checkbox: "Before Food")
                                            }
                                        }
                CheckboxField(title: "After Food", isSelected: $medicineDetail.afterFood)
                    .onChange(of: medicineDetail.afterFood) { value in
                                            if value {
                                                medicineDetail.toggleBeforeAfterFood(checkbox: "After Food")
                                            }
                                        }
            }
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
    var afterFood: Bool = false
    
    mutating func toggleBeforeAfterFood(checkbox: String) {
            if checkbox == "Before Food" {
                beforeFood = true
                afterFood = false
            } else if checkbox == "After Food" {
                beforeFood = false
                afterFood = true
            }
        }
    
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
