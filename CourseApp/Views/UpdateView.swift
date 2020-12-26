//
//  UpdateView.swift
//  CourseApp
//
//  Created by Sean.S.Nguyen on 27/9/20.
//  Copyright © 2020 Sean.S.Nguyen. All rights reserved.
//

import SwiftUI

struct UpdateView: View {
    
    var update: Update
    
    var body: some View {
        VStack(spacing: 30) {
            Image(update.image)
            Text(update.text)
            Spacer()
        }
        .padding(.top, 20)
        .padding(.horizontal, 50)
        .navigationBarTitle(update.title)
    }
}

struct UpdateView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateView(update: Update(image: "Card1", title: "SwiftUI Advanced", text: "Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS.", date: "JAN 1"))
    }
}
