//
//  PaymentDetailsView.swift
//  HMS
//
//  Created by Shashwat Singh on 24/04/24.
//

import SwiftUI

struct PaymentDetailsView: View {
    var body: some View {
        let appointment = AppointmentDetails(doctor: "Dr. Kenny Adeola", patient: "Madilyn Doe", date: "19 Nov, 2023", time: "8:30 AM")
        NavigationStack{
            VStack(spacing:15){
                    Text("Debit Card")
                        .font(.system(size: 20))
                        .bold()
                        .padding(.leading, -180)
                    RoundedRectangle(cornerRadius: 8)
                                .frame(width: 360, height: 50)
                                .foregroundColor(Color.white.opacity(0.2))
                                .shadow(radius: 1)
                                .overlay(
                                    VStack{
                                        HStack{
                                            Image(systemName: "creditcard")
                                                .foregroundColor(.green)
                                            
                                            Text("Add new card")
                                                .foregroundColor(.black)
                                                .font(.headline)
                                            Spacer()
                                            
                                            Text("Add")
                                                .foregroundColor(.green)
                                        }
                                        .padding()
                                    }
                                )
                    Text("Credit Card")
                        .font(.system(size: 20))
                        .bold()
                        .padding(.leading, -180)
                    RoundedRectangle(cornerRadius: 8)
                                .frame(width: 360, height: 50)
                                .foregroundColor(Color.white.opacity(0.2))
                                .shadow(radius: 1)
                                .overlay(
                                    VStack{
                                        HStack{
                                            Image(systemName: "creditcard")
                                                .foregroundColor(.green)
                                            
                                            Text("Add new card")
                                                .foregroundColor(.black)
                                                .font(.headline)
                                            Spacer()
                                            
                                            Text("Add")
                                                .foregroundColor(.green)
                                        }
                                        .padding()
                                    }
                                )
                    Text("More Payment Options")
                        .font(.system(size: 20))
                        .bold()
                        .padding(.leading, -150)
                    RoundedRectangle(cornerRadius: 8)
                                .frame(width: 360, height: 50)
                                .foregroundColor(Color.white.opacity(0.2))
                                .shadow(radius: 1)
                                .overlay(
                                    VStack{
                                        HStack{
                                            Image("applepay")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .foregroundColor(.green)
                                                .frame(width: 40, height: 40)
                                            
                                            Text("Apple Pay")
                                                .foregroundColor(.black)
                                                .font(.headline)
                                            Spacer()
                                            
                                            Text("Pay")
                                                .foregroundColor(.green)
                                        }
                                        .padding()
                                    }
                                )
                    RoundedRectangle(cornerRadius: 8)
                                .frame(width: 360, height: 50)
                                .foregroundColor(Color.white.opacity(0.2))
                                .shadow(radius: 1)
                                .overlay(
                                    VStack{
                                        HStack{
                                            Image("paytm")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .foregroundColor(.green)
                                                .frame(width: 40, height: 40)
                                                
                                            
                                            Text("Paytm")
                                                .foregroundColor(.black)
                                                .font(.headline)
                                            Spacer()
                                            NavigationLink(destination: PaymentConfirmationPage(appointmentDetails: appointment)){
                                                Text("Pay")
                                                    .foregroundColor(.green)
                                            }
                                            
                                            
                                        }
                                        .padding()
                                    }
                                )
                }
                .padding(.bottom, 300)
                .navigationTitle("Payment Options")
        }
    }
}

#Preview {
    PaymentDetailsView()
}
