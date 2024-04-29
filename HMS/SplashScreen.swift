//
//  SplashScreen.swift
//  HMS
//
//  Created by Arul Gupta  on 25/04/24.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var size = 0.6
    @State private var opacity = 0.5
    @ObservedObject var userTypeManager: UserTypeManager
    
    var body: some View {
        
        if isActive {
            SignUpView(userTypeManager: userTypeManager)
  
        } else {
            VStack{
                
                Image("demoLogo")
                
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 2.0)){
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            withAnimation {
                                self.isActive = true
                            }
                        }
                    }
                
                
                

                
                
            }
        }
    }
}


//struct SplashView_Previews: PreviewProvider {
//    static var previews: some View {
//        SplashView()
//    }
//}
