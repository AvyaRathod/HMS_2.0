//
//  DoctorModel.swift
//  HMS
//
//  Created by Anant on 23/04/24.
//

import Foundation

struct DoctorModel: Hashable, Codable, Identifiable {
    var id: String?
    var name: String
    var department: String
    var email: String
    var password: String
    var contact: String
    var experience: Int
    var employeeID: String
    var image: String? // You can store image as URL or any other representation
    var specialization: Specialization
    var degree: String
    var cabinNumber: String

    var appointments: [String]?
    var patients: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case department = "dept"
        case email
        case password
        case contact
        case experience
        case employeeID = "empId"
        case image
        case specialization = "spec"
        case degree
        case cabinNumber = "cabinNo"
        case appointments
        case patients
    }
    
    enum Specialization: String, Codable {
        case Cardiologist = "Cardiologist"
        case Orthopedic = "Orthopedic"
        case Endocrinologist = "Endocrinologist"
        case Gastroenterology = "Gastroenterology"
        case Hematologist = "Hematologist"
        case Neurologist = "Neurologist"
        case Oncologist = "Oncologist"
        case Orthopedist = "Orthopedist"
        case Pediatrician = "Pediatrician"
        case Psychiatrist = "Psychiatrist"
        case Pulmonologist = "Pulmonologist"
        case Rheumatologist = "Rheumatologist"
        case Urologist = "Urologist"
        case Ophthalmologist = "Ophthalmologist"
        case Gynecologist = "Gynecologist"
    }
}
