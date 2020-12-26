//
//  ContentView.swift
//  CourseApp
//
//  Created by Sean.S.Nguyen on 25/9/20.
//  Copyright © 2020 Sean.S.Nguyen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var show: Bool = true
    @State var dragPosition: CGSize = .zero
    @State var bottomDragPosition: CGSize = .zero
    @State var bottomDragging = false
    // shift cmd L
    
    var body: some View {
        ZStack {
            
            TitleView()
                .blur(radius: dragPosition == .zero && show ? 0 : 20)
                .animation(Animation.default)
                //.animation(Animation.default.delay(0.05))
            
            BackCardView()
                .offset(x: 0, y: show ? -40 : -100)
                .offset(x: dragPosition.width, y: dragPosition.height)
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
                .scaleEffect(0.9)
                .foregroundColor(Color("card4"))
                .rotationEffect(.degrees(show ? 7 : 0))
                .blendMode(.hardLight)
            
            BackCardView()
                .offset(x: 0, y: show ? -20 : -50)
                .offset(x: dragPosition.width, y: dragPosition.height)
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
                .scaleEffect(0.95)
                .foregroundColor(Color("card3"))
                .rotationEffect(.degrees(show ? 4 : 0))
                .blendMode(.hardLight)
            
            MainCardView()
                .offset(x: dragPosition.width, y: dragPosition.height)
                .scaleEffect(show ? 1 : 1.05)
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
                .blendMode(.hardLight)
                .onTapGesture {
                    self.show.toggle()
                }
                .gesture(
                    DragGesture().onChanged { value in
                        self.dragPosition = value.translation
                    }
                    .onEnded { _ in
                        self.dragPosition = .zero
                    }
                )
            
            //Text("\(bottomDragPosition.height)").offset(x: 0, y: -300)
            
            BottomView()
                //.blur(radius: dragPosition == .zero && show ? 0 : 20)
                .offset(x: 0, y: dragPosition == .zero && !show ? 500 : 1000)
//                .offset(x: 0, y: bottomDragging ? bottomDragPosition.height : 0)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.6))
                .gesture(
                    DragGesture().onChanged { value in
                        self.bottomDragPosition.height = value.translation.height
                        self.bottomDragging = true
                    }
                    .onEnded { value in
                        self.bottomDragging = false
                        if self.bottomDragPosition.height > 60 {
                            self.show.toggle()
                            self.bottomDragPosition = .zero
                        }
                    }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TitleView: View {
    var body: some View {
        
        VStack {
            HStack {
                Text("Certificates")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            Image("Background1")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
        }
        .padding()
    }
}

struct BackCardView: View {
    var body: some View {
        //            VStack {
        //                Spacer()
        //            }
        Rectangle()
            .frame(width: 340, height: 220)
            .cornerRadius(20)
            .shadow(radius: 20)
            
    }
}

struct MainCardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Cloud Engineer")
                        .font(.title)
                        .fontWeight(.semibold)
                    Text("Level 1")
                        .foregroundColor(Color("accent"))
                }
                .foregroundColor(Color.white)
                
                Spacer()
                Image("Logo1")
            }
            .padding()
            Spacer()
            Image("Card1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 110, alignment: .top)
        }
        .frame(width: 340, height: 220)
        .background(Color.black)
        .cornerRadius(20)
        .shadow(radius: 20)
    }
}

struct BottomView: View {
        
    var body: some View {
        VStack(spacing: 20) {
            Rectangle().frame(width: 50, height: 5)
                .cornerRadius(3)
                .opacity(0.3)
            Text("This certificate is proof that completed all the labs for Cloud Engineer")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
            
            HStack(spacing: 20) {
                ProgressRingView(color1: Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), color2: Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)), size: 88, percentage: 78)
                
                VStack(alignment: .leading, spacing: 8) {
                            Text("Google Lab")
                                .fontWeight(.bold)
                            Text("10 of 12 sections completed \n10 hours spent so far")
                                .font(.footnote)
                                .foregroundColor(.gray)
                                .lineSpacing(4)
                }
                    // add padding
                    .padding(20)
                    .background(Color("background3"))
                    // makes the shape rounded rectangle
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    // Add shadow for 3D effect
                    .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color("background1"))
        .cornerRadius(30)
        .shadow(radius: 25)
    }
}
