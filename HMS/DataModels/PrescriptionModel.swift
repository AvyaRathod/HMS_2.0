//
//  PrescriptionModel.swift
//  HMS
//
//  Created by Vishnu on 29/04/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct PrescriptionModel: Codable, Identifiable {
    let id = UUID()
    let doctorId: String
    let patentId: String
    var prescription: String
    var patientStatus: String
    var description: String
    var referedDoctorId: String?
    var prescribedMedicines: [String: MedicineDetails]
    var prescribedTest: [String]?
    
    struct MedicineDetails: Codable {
        let dosage: String
        let intakePattern: [IntakeTime]
        let beforeFood: Bool
        let afterFood: Bool
    }
    
    enum IntakeTime: String, Codable {
        case morning = "Morning"
        case afternoon = "Afternoon"
        case night = "Night"
    }
    
    init(doctorId: String, patentId: String, prescription: String, patientStatus: String, description: String, referedDoctorId: String? = nil, prescribedMedicines: [String : MedicineDetails], prescribedTest: [String]? = nil) {
        self.doctorId = doctorId
        self.patentId = patentId
        self.prescription = prescription
        self.patientStatus = patientStatus
        self.description = description
        self.referedDoctorId = referedDoctorId
        self.prescribedMedicines = prescribedMedicines
        self.prescribedTest = prescribedTest
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.doctorId = try container.decode(String.self, forKey: .doctorId)
        self.patentId = try container.decode(String.self, forKey: .patentId)
        self.prescription = try container.decode(String.self, forKey: .prescription)
        self.patientStatus = try container.decode(String.self, forKey: .prescribedTest)
        self.description = try container.decode(String.self, forKey: .description)
        self.referedDoctorId = try container.decodeIfPresent(String.self, forKey: .referedDoctorId)
        self.prescribedMedicines = try container.decode([String: MedicineDetails].self, forKey: .prescribedMedicines)
        self.prescribedTest = try container.decodeIfPresent([String].self, forKey: .prescribedTest)
    }
}

final class PrescriptionManager {
    static let shared = PrescriptionManager()
    private init() {}
    
    private let prescriptionCollection = Firestore.firestore().collection("prescriptions")
    
    
    func addPatientRecord(patientId: String, prescriptionData: PrescriptionModel) {
        do {
            let data = try Firestore.Encoder().encode(prescriptionData)
            
            prescriptionCollection.document(patientId).setData(data) { error in
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
    
    
    func editPatientRecord(patientId: String, doctorId: String, updatedPrescriptionData: PrescriptionModel) {
        do {
            let updatedData = try Firestore.Encoder().encode(updatedPrescriptionData)
            
            prescriptionCollection.document(patientId).updateData(updatedData) { error in
                if let error = error {
                    print("Error updating document: \(error)")
                } else {
                    print("Document updated successfully")
                }
            }
        } catch {
            print("Error encoding updated prescription data: \(error)")
        }
    }
    
}
