//
//  PatientModel.swift
//  HMS
//
//  Created by Anant on 23/04/24.
//

import Foundation


struct PatientModel: Hashable, Codable, Identifiable {
    var id: String?
    var name: String?
    var dateOfBirth: Date?
    var height: Float?
    var weight: Float?
    var bloodGroup: BloodGroup?
    var address: String?
    var contact: String?
    var email: String?
    var emergencyContact: String?
    var gender: Gender?

    enum Gender: String, CaseIterable, Codable {
        case male = "Male"
        case female = "Female"
        case others = "Others"
    }

    enum BloodGroup: String, CaseIterable, Codable {
        case APositive = "A+"
        case ANegative = "A-"
        case BPositive = "B+"
        case BNegative = "B-"
        case ABPositive = "AB+"
        case ABNegative = "AB-"
        case OPositive = "O+"
        case ONegative = "O-"
    }

    // Initializer
    init(id: String? = nil, name: String? = nil, dateOfBirth: Date? = nil, height: Float? = nil, weight: Float? = nil, bloodGroup: BloodGroup? = nil, address: String? = nil, contact: String? = nil, email: String? = nil, emergencyContact: String? = nil, gender: Gender? = nil) {
        self.id = id
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.height = height
        self.weight = weight
        self.bloodGroup = bloodGroup
        self.address = address
        self.contact = contact
        self.email = email
        self.emergencyContact = emergencyContact
        self.gender = gender
    }
}
