import SwiftUI
import Firebase
import FirebaseAuth

struct AddPrescriptionForm: View {
    
    @State private var patientId = ""
    @State private var patientStatus = ""
    @State private var appointmentID = ""
    @State private var description = ""
    @State private var referedDoctorId = ""
    @State private var medicines: [MedicineDetail] = []
    @State private var medicineName = ""
    @State private var dosage = ""
    @State private var prescription = ""
    @State private var intakeMorning = false
    @State private var intakeAfternoon = false
    @State private var intakeNight = false
    @State private var beforeFood = false
    @State private var afterFood = false
    @State private var prescribedTest = ""
    @State private var isAdmitted = false // Added
    
    @StateObject private var viewModel = PrescriptionViewModel()
    
    init(patientId: String, appointmentID: String) {
        self._patientId = State(initialValue: patientId)
        self._appointmentID = State(initialValue: appointmentID)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Text("Patient Id: \(patientId)")
                Section(header: Text("Prescription Details")) {
                    TextField("Patient Condition", text: $patientStatus)
                    TextEditor(text: $prescription)
                        .foregroundColor(.black)
                        .frame(minHeight: 100)
                    
                    
                    TextField("Description", text: $description)
                }
                Section{
                    NavigationLink(destination: DRecordsView(patientId: patientId), label: {
                        Text("Show records")
                    })
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
                                    
                // Added Toggle for Admission Status
                Section(header: Text("Admission Status")) {
                    Toggle("Admitted", isOn: $isAdmitted)
                }
                
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
    
    func addPatientRecord(patientId: String, doctorId: String, prescriptionData: PrescriptionModel) {
        do {
            // Encode prescriptionData
            let data = try Firestore.Encoder().encode(prescriptionData)
            
            // Get a reference to the Firestore collection and add the data
            let collectionRef = Firestore.firestore().collection("prescriptions") // Adjust the collection name as needed
            collectionRef.addDocument(data: data) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added successfully")
                }
            }
        } catch {
            print("Error encoding prescription data: \(error)")
        }
        
        
    }
    
    func admitPatient(isAdmitted: Bool) {
        
        guard isAdmitted else {
                return
        }
        
        guard let doctorId = viewModel.currentUser?.uid else {
            print("Doctor ID not available.")
            return
        }

        let admissionData = Admit(id: UUID().uuidString, patientId: patientId, doctorId: doctorId, appointmentID: appointmentID)

        let db = Firestore.firestore()
        let admitsCollection = db.collection("admits")

        let admissionDictionary: [String: Any] = [
            "id": admissionData.id,
            "patientId": admissionData.patientId,
            "doctorId": admissionData.doctorId,
            "appointmentID": admissionData.appointmentID,
            "isAdmitted": isAdmitted
        ]

        admitsCollection.addDocument(data: admissionDictionary) { error in
            if let error = error {
                print("Error admitting patient: \(error)")
            } else {
                print("Patient admitted successfully.")
            }
        }
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
        
        guard let currentUserID = viewModel.currentUser?.uid else {
            print("Current user ID not available.")
            return
        }
        
        
        
        guard let prescriptionData = PrescriptionModel(
            dictionary: [
                "doctorId": currentUserID,
                "patentId": patientId,
                "appointmentID": appointmentID,
                "prescription": "",
                "patientStatus": patientStatus,
                "description": description,
                "isAdmitted": isAdmitted,
                "prescribedMedicines": prescribedMedicines.mapValues { medicineDetails in
                    [
                        "dosage": medicineDetails.dosage,
                        "intakePattern": medicineDetails.intakePattern.map { $0.rawValue }, // Corrected
                        "beforeFood": medicineDetails.beforeFood,
                        "afterFood": medicineDetails.afterFood
                    ]
                }
            ],
            id: UUID().uuidString
        ) else { return }

        addPatientRecord(patientId: patientId, doctorId: currentUserID, prescriptionData: prescriptionData)
        admitPatient(isAdmitted: isAdmitted)
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
    AddPrescriptionForm(patientId: "0rkVOvnoW2WEUu9NJfo82uVKhW72", appointmentID: "DCVtVsKE1tJesdnwkVX3")
}
