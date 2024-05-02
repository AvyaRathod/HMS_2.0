//
//  EventsModel.swift
//  HMS
//
//  Created by Protyush Kundu on 30/04/24.
//

import SwiftUI

struct HealthEvent: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var date: String
    var time: String
    var venue: String
    var imageName: String // Image name for the event
}

// Sample data for demonstration
let sampleHealthEvents: [HealthEvent] = [
    HealthEvent(title: "Fitness Workshop", description: "Join us for an exciting fitness workshop where you'll learn about the latest trends in fitness and wellness.", date: "May 10, 2024", time: "10:00 AM", venue: "Fitness Center", imageName: "fitness"),
    HealthEvent(title: "Nutrition Seminar", description: "Learn about healthy eating habits and nutritional tips in this informative seminar.", date: "May 15, 2024", time: "2:00 PM - 4:00 PM", venue: "Conference Room", imageName: "nutrition_seminar"),
    HealthEvent(title: "Mental Health Awareness Session", description: "Join us for an insightful session on mental health awareness and strategies for better mental well-being.", date: "May 20, 2024", time: "3:00 PM - 5:00 PM", venue: "Auditorium", imageName: "mental_health_session"),
    HealthEvent(title: "Yoga Retreat", description: "Relax and rejuvenate with a serene yoga retreat in the beautiful outdoor park.", date: "May 25, 2024", time: "8:00 AM - 10:00 AM", venue: "Outdoor Park", imageName: "yoga_retreat"),
    HealthEvent(title: "Blood Donation", description: "Join us for an exciting fitness workshop where you'll learn about the latest trends in fitness and wellness.", date: "May 10, 2024", time: "10:00 AM - 12:00 PM", venue: "Fitness Center", imageName: "fitness_"),
]

