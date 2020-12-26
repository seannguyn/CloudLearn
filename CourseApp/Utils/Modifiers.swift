//
//  Modifiers.swift
//  CourseApp
//
//  Created by Sean.S.Nguyen on 25/12/20.
//  Copyright © 2020 Sean.S.Nguyen. All rights reserved.
//

import SwiftUI

struct RoundedRectangleShadowModifiers: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color("background3")).opacity(0.8)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color.black.opacity(0.5), radius: 4, x: 0.0, y: 0.0)
    }
}

struct CustomFont: ViewModifier {
    let size: CGFloat
    func body(content: Content) -> some View {
        content
            .font(.custom("WorkSans-Bold", size: size))
    }
}

extension View {
    func roundedRectangleShadowModifiers() -> some View {
        self.modifier(RoundedRectangleShadowModifiers())
    }
    
    func customFont(size: CGFloat) -> some View {
        self.modifier(CustomFont(size: size))
    }
}
