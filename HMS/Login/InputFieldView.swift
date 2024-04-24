//
//  InputFieldView.swift
//  HMS
//
//  Created by Sarthak on 23/04/24.
//

import SwiftUI

struct InputFieldView: View {
   
  @Binding var data:String
  var title: String?
   
  var body: some View {
    ZStack {
     TextField("", text: $data)
      .padding(.horizontal, 10)
      .frame(width: 360, height: 52)
      .overlay(
       RoundedRectangle(cornerSize: CGSize(width: 4, height: 4))
         .stroke(Color.gray, lineWidth: 1)
      )
     HStack {
      Text(title ?? "Input")
       .font(.headline)
       .fontWeight(.medium)
       .foregroundColor(Color.black)
       .multilineTextAlignment(.leading)
       .padding(.bottom,4)
       .background(Color(Color.white))
      Spacer()
     }
     .padding(.leading, 18)
     .offset(CGSize(width: 0, height: -25))
    }.padding(4)
  }
}

#Preview {
  InputFieldView(data: .constant(""))
}
