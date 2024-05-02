//
//  EmergencyModel.swift
//  HMS
//
//  Created by Anant on 02/05/24.
//
import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct EmergencyModel: Codable {
    
    let patientId: String
    let latitude: String
    let longitude: String
    
    init(patientId: String, latitude: String, longitude: String) {
        self.patientId = patientId
        self.latitude = latitude
        self.longitude = longitude
    }
    
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.patientId = try container.decode(String.self, forKey: .patientId)
        self.latitude = try container.decode(String.self, forKey: .latitude)
        self.longitude = try container.decode(String.self, forKey: .longitude)
    }
    
    
    
}

final class EmergencyManager {
    static let shared = EmergencyManager()
    private init() {}
    
    private let emergenciesCollection = Firestore.firestore().collection("Emergency")
    
    func addEmergency(patientId: String, latitude: String, longitude: String) {
        let emergencyData = EmergencyModel(patientId: patientId, latitude: latitude, longitude: longitude)
            do {
                _ = try emergenciesCollection.addDocument(from: emergencyData)
            } catch {
                print("Error adding emergency data to Firestore: \(error)")
            }
        }
}
