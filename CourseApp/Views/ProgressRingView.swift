//
//  ProgressRingView.swift
//  CourseApp
//
//  Created by Sean.S.Nguyen on 25/12/20.
//  Copyright © 2020 Sean.S.Nguyen. All rights reserved.
//

import SwiftUI

struct ProgressRingView: View {
    
    var color1 = Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1))
    var color2 = Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))
    var size: CGFloat = 88
    var percentage: CGFloat = 31
    @State var show: Bool = true
    
    var body: some View {
        
        let progress: CGFloat = 1 - percentage/100
        
        // this helps other components scale as the size change
        let multiplier = size / 44
        
        return ZStack {
            Circle()
                // stroke is used to only draw the border
                // content is basically the color or gradident
                // style is linewidth, line cap, dash, etc
                .stroke(
                    Color.black.opacity(0.2),
                    style: StrokeStyle(lineWidth: 5 * multiplier, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [], dashPhase: 0)
                )
            
            Circle()
                // 0.1 trim means that 90% of the circle remains
                .trim(from: show ? progress : 1, to: 1)
                // stroke is used to only draw the border
                // content is basically the color or gradident
                // style is linewidth, line cap, dash, etc
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [color1, color2]), startPoint: .topTrailing, endPoint: .bottomLeading),
                    style: StrokeStyle(lineWidth: 5 * multiplier, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [], dashPhase: 0)
                )
                .rotationEffect(Angle(degrees: 90))
                // reflected, and rotate in different direction
                .rotation3DEffect(
                    Angle(degrees: 180),
                    axis: (x: 1.0, y: 0.0, z: 0.0)
                )
                .shadow(color: color2.opacity(0.3), radius: 10, x: 0.0, y: 0.0)
//                .animation(Animation.easeInOut)
            
            Text("\(Int(percentage))%")
                .font(.system(size: 14 * multiplier))
                .fontWeight(.bold)
//                .onTapGesture {
//                    show.toggle()
//                }
        }
        .frame(width: size, height: size)
    }
}

struct ProgressRingView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRingView(show: true)
    }
}
