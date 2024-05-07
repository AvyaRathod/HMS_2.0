//
//  PaymentDetailsView.swift
//  HMS
//
//  Created by Avya Rathod on 11/01/24.
//

import SwiftUI

struct CheckoutView: View {
    
    var doctorName: String
    var selectedDate: String
    var selectedSlot: String
    
    
    
//    @Binding var startDate: Date
//    @Binding var endDate: Date
//    @Binding var startTime: Date
//    @Binding var endTime: Date
//    @Binding var selectedPets: Set<String>
//    @Binding var selectedService: String
    
    @State private var selectedPaymentMethod: String?
    
    var PrefPaymentOpt = ["Paytm UPI", "Google Pay" , "Pay at the end(Cash/UPI)"]
    var otherPaymentOpt = ["asdf@okhdfcbank", "omvin@aubank"]

    var body: some View {
        VStack{
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    
                    // Booking Details
                    VStack{
                        VStack(alignment: .leading) {
                            Text(doctorName)
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        .padding()
                        
                        Divider()
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("From")
                                Text(selectedDate)
                                    .fontWeight(.bold)
                                Text(selectedSlot)
                                    .fontWeight(.bold)
                            }
                            Spacer()
                            Divider()
                                .frame(height: 50.0)
                            Spacer()
                            VStack(alignment: .leading) {
                                Text("To")
                                Text(selectedDate)
                                    .fontWeight(.bold)
                                Text(selectedSlot)
                                    .fontWeight(.bold)
                            }
                        }
                        .padding([.leading, .trailing])
                        
                        Divider()
                        
                        // Price Details
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Price")
                                    .font(.title2)
                                Spacer()
                                Text("1000")
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                            .padding([.leading, .trailing, .top])
                            
                            HStack {
                                Spacer()
                                Text("Incl. of all taxes")
                                    .foregroundColor(.secondary)
                            }
                            .padding([.leading, .trailing])
                        }
                    }
                    .padding()
                    .frame(width:360)
                    .background (.white)
                    .clipShape (RoundedRectangle (cornerRadius: 12))
                    .padding()
                    .shadow(radius: 10)
                    
                    // Payment options
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Preferred payment options")
                            .font(.headline)
                            .padding(.bottom, 5)
                        
                        ForEach(PrefPaymentOpt, id: \.self) { paymentOption in
                            PaymentMethodView(
                                methodName: paymentOption,
                                doctorName: self.doctorName,
                                selectedDate: self.selectedDate,
                                selectedSlot: self.selectedSlot,
                                selectedPaymentMethod: $selectedPaymentMethod
                            )
                        }

                        
                        Text("Pay by any UPI App")
                            .font(.headline)
                            .padding(.top)
                        
                        VStack {
                            ForEach(PrefPaymentOpt, id: \.self) { paymentOption in
                                PaymentMethodView(
                                    methodName: paymentOption,
                                    doctorName: self.doctorName,
                                    selectedDate: self.selectedDate,
                                    selectedSlot: self.selectedSlot,
                                    selectedPaymentMethod: $selectedPaymentMethod
                                )
                            }

                            
                            Button("Add New UPI ID") {
                                // Implement the Add New UPI action
                            }
                            .foregroundColor(.blue)
                        }
                        
                    }
                    .padding(.horizontal)
                    
                }
            }

        }
        .navigationTitle("Final Step")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PaymentMethodView: View {
    var methodName: String
    var doctorName: String
    var selectedDate: String
    var selectedSlot: String
    @Binding var selectedPaymentMethod: String?

    var body: some View {
        VStack {
            HStack {
                Text(methodName)
                    .fontWeight(.medium)
                Spacer()
                Image(systemName: selectedPaymentMethod == methodName ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(selectedPaymentMethod == methodName ? .blue : .gray)
            }

            if selectedPaymentMethod == methodName {
                NavigationLink(destination: PaymentConfirmationPage(doctorName: doctorName, selectedDate: selectedDate, selectedSlot: selectedSlot)) {
                    Text("Pay via \(methodName)")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.systemGray6)))
        .onTapGesture {
            self.selectedPaymentMethod = methodName
        }
    }
}




struct CheckoutView_Previews: PreviewProvider {
    @State static var mockDestination: String = "Guduvancheri, India"
    @State static var mockStartDate: Date = Date()
    @State static var mockEndDate: Date = Date()
    @State static var selectedService = "walking"
    @State static var selectedPets:Set<String> = ["Tuffy", "Jerry", "Max", "Buddy"]
  
    
    static var previews: some View {
        NavigationView {
            CheckoutView(doctorName: "Dr. Kenny Adeola", selectedDate: "19 Nov, 2023", selectedSlot: "8:30 AM")
        }
    }
}
