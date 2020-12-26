//
//  MenuView.swift
//  CourseApp
//
//  Created by Sean.S.Nguyen on 26/9/20.
//  Copyright © 2020 Sean.S.Nguyen. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 16) {
                Text("28% completed").font(.system(size: 12))
                
                Color.white
                    .frame(width: 36, height: 6)
                    .cornerRadius(3)
                    .frame(width: 130, height: 6, alignment: .leading)
                    .background(Color.black.opacity(0.2))
                    .cornerRadius(3)
                    .frame(width: 150, height: 20)
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(12)
                
//                Text("haha")
//                    .frame(width: 60, height: 30)
//                    .frame(width: 300, height: 40, alignment: .leading)
                    
                
                MenuItemView(systemImageName: "gear", description: "Account")
                MenuItemView(systemImageName: "creditcard", description: "Billing")
                MenuItemView(systemImageName: "person", description: "Sign out")
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
                // put background before clipshape
                // padding put last
            .background(LinearGradient(gradient: Gradient(colors: [Color("background1"), Color("background2")]), startPoint: .top, endPoint: .trailing)).opacity(0.8)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .padding(.horizontal, 30)
//            .shadow(radius: 20)
                .shadow(color: Color.black.opacity(0.4), radius: 20, x: 0, y: 20)
            // have to use overlay here because clip shape will clip the image
                .overlay(
                    Image("Logo1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .offset(x: 0, y: -150)
                        .frame(width: 60, height: 60)
                )
        }
        .padding(.bottom, 10)
    }
}

struct MenuItemView : View {
    
    var systemImageName: String
    var description: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: systemImageName)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(Color(#colorLiteral(red: 0.662745098, green: 0.7333333333, blue: 0.831372549, alpha: 1)))
                
            Text(description)
                .font(.subheadline)
                .fontWeight(.bold)
                .frame(width: 120, alignment: .leading)
        }
        .padding(.horizontal, 30)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
