//
//  HomeView.swift
//  CourseApp
//
//  Created by Sean.S.Nguyen on 26/9/20.
//  Copyright © 2020 Sean.S.Nguyen. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @State var showProfile: Bool = false
    @State var profileDrag: CGSize = .zero
    
    var body: some View {
        
        ZStack {
            
            Color("background1").edgesIgnoringSafeArea(.all)
            
            MainView(showProfile: $showProfile)
//            .edgesIgnoringSafeArea(.all) // put this at the end
            .padding(.top, 44)
                .background(LinearGradient(gradient: Gradient(colors: [Color("background1"), Color("background2")]), startPoint: .top, endPoint: .bottom))
//                .background(Color.red)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .scaleEffect(showProfile ? 0.9 : 1)
            .shadow(color: Color.black.opacity(0.4), radius: 20, x: 0, y: 20)
            .rotation3DEffect(.degrees(showProfile ? -10 : 0), axis: (10, 0, 0))
//                .offset(x: 0, y: showProfile ? -100 : 0)
                .blur(radius: showProfile ? 5 : 0)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                self.showProfile = false
            }
            
            MenuView()
                .offset(x: 0, y: showProfile ? 0 : screen.height)
                .offset(x: 0, y: profileDrag.height)
                .animation(Animation.spring(response: 0.4, dampingFraction: 0.7, blendDuration: 0))
                .gesture(
                    DragGesture()
                    .onChanged { value in
                        self.profileDrag = value.translation
                    }
                    .onEnded { value in
                        if value.translation.height > 50 {
                            self.showProfile = false
                        }
                        self.profileDrag = .zero
                    }
                )
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

let screen = UIScreen.main.bounds
