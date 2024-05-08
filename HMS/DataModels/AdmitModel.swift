//
//  AdmitModel.swift
//  HMS
//
//  Created by Vishnu on 08/05/24.
//

import Foundation

struct Admit {
    let id: String
    let patientId: String
    let doctorId: String
    let appointmentID: String
    
    init(id: String, patientId: String, doctorId: String, appointmentID: String) {
        self.id = id
        self.patientId = patientId
        self.doctorId = doctorId
        self.appointmentID = appointmentID
    }
}
