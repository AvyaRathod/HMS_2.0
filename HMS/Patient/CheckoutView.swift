//
//  PaymentDetailsView.swift
//  HMS
//
//  Created by Avya Rathod on 11/01/24.
//

import SwiftUI

struct CheckoutView: View {
    
    @Binding var startDate: Date
    @Binding var endDate: Date
    @Binding var startTime: Date
    @Binding var endTime: Date
    @Binding var selectedPets: Set<String>
    @Binding var selectedService: String
    
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
                            Text("Doctor.name")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        .padding()
                        
                        Divider()
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("From")
                                Text(startDate, style: .date)
                                    .fontWeight(.bold)
                                Text(startTime, style: .time)
                                    .fontWeight(.bold)
                            }
                            Spacer()
                            Divider()
                                .frame(height: 50.0)
                            Spacer()
                            VStack(alignment: .leading) {
                                Text("To")
                                Text(endDate, style: .date)
                                    .fontWeight(.bold)
                                Text(endTime, style: .time)
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
                                            PaymentMethodView(methodName: paymentOption, selectedPaymentMethod: $selectedPaymentMethod,
                                                              startDate: $startDate,
                                                              endDate: $endDate,
                                                              startTime: $startTime,
                                                              endTime: $endTime,
                                                              selectedPets:$selectedPets,
                                                              selectedService:$selectedService)
                                        }
                        
                        Text("Pay by any UPI App")
                            .font(.headline)
                            .padding(.top)
                        
                        VStack {
                            ForEach(otherPaymentOpt, id: \.self) { paymentOption in
                                                PaymentMethodView(methodName: paymentOption, selectedPaymentMethod: $selectedPaymentMethod,                                                      startDate: $startDate,
                                                                  endDate: $endDate,
                                                                  startTime: $startTime,
                                                                  endTime: $endTime,
                                                                  selectedPets:$selectedPets,
                                                                  selectedService:$selectedService)
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
//            VStack(alignment: .leading) {
//                Divider()
//                HStack {
//                    Text(results.cost)
//                        .font(.title)
//                        .fontWeight(.bold)
//                }
//                .padding([.leading, .trailing, .top])
//            }
        }
        .navigationTitle("Final Step")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PaymentMethodView: View {
    var methodName: String
    @Binding var selectedPaymentMethod: String?
    
    @Binding var startDate: Date
    @Binding var endDate: Date
    @Binding var startTime: Date
    @Binding var endTime: Date
    @Binding var selectedPets: Set<String>
    @Binding var selectedService: String

    @State private var navigateToConfirmation = false

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
                Button(action: {
                    if methodName == "Pay on Delivery (Cash/UPI)" {
                        
                    } else {
                        
                    }
                    navigateToConfirmation = true
                }) {
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
        .navigationDestination(isPresented: $navigateToConfirmation) {
            EmptyView()
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
            CheckoutView(startDate: $mockStartDate, endDate: $mockEndDate, startTime: $mockStartDate, endTime: $mockEndDate,
                         selectedPets:$selectedPets,
                         selectedService:$selectedService)
        }
    }
}
