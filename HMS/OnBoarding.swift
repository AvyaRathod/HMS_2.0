//
//  OnBoarding.swift
//  HMS
//
//  Created by Arul Gupta  on 25/04/24.
//

import SwiftUI

struct OnBoarding: View {
    
    @State private var  PageIndex = 0
    private let pages: [Page] = Page.samplePages
    private let dotAppearance = UIPageControl.appearance()
    
    
    
    var body: some View {
        TabView(selection:  $PageIndex){
            ForEach(pages){
                page in VStack{
                    Spacer()
                    PageView(page: page)
                    Spacer()
                    if page == pages.last{
                        Button("Sign Up", action: goToZero)
                            .buttonStyle(.bordered )
                    }
                    else{
                        Button("Next",action:incrementPage)
                    }
                    Spacer()
                }
                .tag(page.tag)
            }
        }
        .animation(.easeInOut,value: PageIndex)
        .tabViewStyle(.page )
        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
        .onAppear{
            dotAppearance.currentPageIndicatorTintColor = .black
            dotAppearance.pageIndicatorTintColor = .gray
        }
               
    }
    func incrementPage(){
        PageIndex += 1
    }
    func goToZero(){
        PageIndex = 0
    }
}

#Preview {
    OnBoarding()
}
