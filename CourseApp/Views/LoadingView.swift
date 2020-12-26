//
//  LoadingView.swift
//  CourseApp
//
//  Created by Sean.S.Nguyen on 26/12/20.
//  Copyright © 2020 Sean.S.Nguyen. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    
    @State var spin: Bool = false
    
    var body: some View {
//        VStack {
//            LottieView(filename: "loading")
//                .frame(width: 200, height: 200)
//        }
        VStack {
            Text("Logging in...").font(.system(size: 20))
            Circle()
                .stroke(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.red]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/), style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round, miterLimit: 0, dash: [20,20], dashPhase: 0))
                .rotationEffect(spin ? Angle(degrees: 360) : Angle(degrees: 0))
                .animation(Animation.linear(duration: 2).repeatForever(autoreverses: false))
                .onAppear {
                    spin = true
                }
                .frame(width: 150, height: 150)
        }
        .padding()
        .frame(width: 200, height: 200)
        .background(Color("background1"))
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
