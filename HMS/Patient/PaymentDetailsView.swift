//
//  PaymentDetailsView.swift
//  HMS
//
//  Created by Shashwat Singh on 24/04/24.
//

import SwiftUI

struct PaymentDetailsView: View {
    var body: some View {
        NavigationView{
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
                                                .foregroundColor(.black)
                                            
                                            Text("Add new card")
                                                .foregroundColor(.black)
                                                .font(.headline)
                                            Spacer()
                                            NavigationLink(destination: PaymentConfirmationPage()){
                                                Text("Add")
                                                    .foregroundColor(.green)
                                            }
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
                                                .foregroundColor(.black)
                                            
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
                                            Image("apple")
                                                .resizable()
                                                .frame(width: 20, height: 20)
                                                .foregroundColor(.green)
                                            
                                            Text("Apple Pay")
                                                .foregroundColor(.black)
                                                .font(.headline)
                                            Spacer()
                                            
                                            Text("Add")
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
                                            Image("google")
                                                .resizable()
                                                .frame(width: 20, height: 20)
                                                .foregroundColor(.green)
                                            
                                            Text("Google Pay")
                                                .foregroundColor(.black)
                                                .font(.headline)
                                            Spacer()
                                            
                                            Text("Add")
                                                .foregroundColor(.green)
                                        }
                                        .padding()
                                    }
                                )
                }
                .padding(.bottom, 390)
        }
        .navigationTitle("Payment Options")
    }
}

#Preview {
    PaymentDetailsView()
}
