//
//  LoginView.swift
//  HMS
//
//  Created by Sarthak on 23/04/24.
//

import SwiftUI
import Firebase

enum userType{
    case patient
    case admin
    case doctor
}

struct LoginView: View {

    
    @State var usernameTitle : String = "Username"
    @State var passwordTitle : String = "Password"
     
    @State var username : String = ""
    @State var password : String = ""
  var body: some View {
    NavigationStack{
      ZStack{
        Color(Color.white)
          .ignoresSafeArea()
        VStack{
          Text("Welcome Back !").font(.largeTitle).fontWeight(.bold).padding(.bottom,42)
          VStack(spacing:16.0){
            InputFieldView(data: $username, title: usernameTitle).autocorrectionDisabled()
            InputFieldView(data: $password, title: passwordTitle).autocorrectionDisabled()
          }.padding(.bottom,25)
          Button(action: {
              login()
              print("login")
          }) {
            Text("Log In")
              .fontWeight(.heavy)
              .font(.title3)
              .frame(width:300)
              .padding()
              .foregroundColor(.white)
              .background(Color(Color.black))
              .cornerRadius(40)
          }
          HStack {
            Spacer().frame(maxWidth: 160)
            Text("Forgot Password?")
              .fontWeight(.light)
              .foregroundColor(Color.blue)
              .underline()
          }.padding(.top, 15)
           
          Image("Line or").padding(.leading,-6)
            
          NavigationLink{
            SignUpView()
          } label: {
            Text("Sign In")
              .fontWeight(.heavy)
              .font(.title3)
              .frame(width:300)
              .padding()
              .foregroundColor(.white)
              .background(Color(Color.black))
              .cornerRadius(40)
          }.padding()
            
            Text(" or sign in with").font(.title3)
            
           
            HStack{
                Button(action: {print("Apple")}){
                    Image("apple")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.black)
                }.padding(.bottom,-150).padding()
                
                
                Button(action: {print("Apple")}){
                    Image("google")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.black)
                }.padding(.bottom,-150)
                
                
                
            }
            
           
          //        VStack{
          //
          //          Text("Don't have an account? Create one !")
          //        }.frame(alignment: .bottom)
           
        }
          
      }
    }
  }
    
    func login() {
        Auth.auth().signIn(withEmail: username, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let result = result {
                let userUID = result.user.uid
                print("User UID: \(userUID)")
                self.fetchUserType(userUID: userUID)
            }
        }
    }

    func fetchUserType(userUID: String) {
        let db = Firestore.firestore()
        let ref = db.collection("userType").whereField("authID", isEqualTo: userUID)

        ref.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let userType = document.data()["user"] as? String ?? "Unknown"
                    print("User Type: \(userType)")
                }
            }
        }
    }

}

#Preview {
  LoginView()
}
