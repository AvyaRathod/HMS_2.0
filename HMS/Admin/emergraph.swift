import SwiftUI
import Charts
import FirebaseFirestore

struct ChartUi: View {
    @State private var emergencyData: [EmergencyDataPoint] = []
    
    var body: some View {
        VStack {
            Text("Emergency")
                .font(.title2)
                .padding()
            if !emergencyData.isEmpty {
                Chart {
                    ForEach(emergencyData) { dataPoint in
                        LineMark(
                            x: .value("Time", dataPoint.time),
                            y: .value("Date", dataPoint.date)
                        )
                    }
                }
                .padding()
            } else {
                Text("Loading...")
            }
        }.frame(height: 250)
        .onAppear {
            fetchEmergencyData()
        }
    }
    
    func fetchEmergencyData() {
        let db = Firestore.firestore()
        db.collection("Emergency").getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("Error fetching documents: \(error ?? NSError())")
                return
            }
            
            self.emergencyData = documents.compactMap { document in
                if let timestamp = document.data()["timeStamp"] as? Timestamp {
                    let date = timestamp.dateValue()
                    // Extract time component from the date
                    let timeFormatter = DateFormatter()
                    timeFormatter.dateFormat = "HH:mm:ss"
                    let time = timeFormatter.string(from: date)
                    return EmergencyDataPoint(date: date, time: time)
                } else {
                    return nil
                }
            }
        }
    }
}

struct EmergencyDataPoint: Identifiable {
    let id = UUID()
    let date: Date
    let time: String
}

struct ContentView_Previews1: PreviewProvider {
    static var previews: some View {
        ChartUi()
    }
}
