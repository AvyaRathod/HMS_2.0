//
//  AdmitModel.swift
//  HMS
//
//  Created by Vishnu on 08/05/24.
//

import Foundation

struct Admit {
    var id: String
    var patientId: String
    var doctorId: String
    var appointmentID: String

    init(id: String, patientId: String, doctorId: String, appointmentID: String) {
        self.id = id
        self.patientId = patientId
        self.doctorId = doctorId
        self.appointmentID = appointmentID
    }

    init?(dictionary: [String: Any], id: String) {
        guard let patientId = dictionary["patientId"] as? String,
              let doctorId = dictionary["doctorId"] as? String,
              let appointmentID = dictionary["appointmentID"] as? String else {
            return nil
        }

        self.id = id
        self.patientId = patientId
        self.doctorId = doctorId
        self.appointmentID = appointmentID
    }
}
