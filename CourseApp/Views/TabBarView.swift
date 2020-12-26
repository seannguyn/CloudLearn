//
//  TabBar.swift
//  CourseApp
//
//  Created by Sean.S.Nguyen on 27/9/20.
//  Copyright © 2020 Sean.S.Nguyen. All rights reserved.
//

import SwiftUI

struct TabBarView: View {
    
    @State var authenticated: Bool = false

    var body: some View {
        Group {
            if (authenticated) {
                TabView() {
                    HomeView().tabItem {
                        Image(systemName: "play.circle.fill")
                        Text("Home")
                    }
                    MyCourseListView().tabItem {
                        Image(systemName: "rectangle.stack.fill")
                        Text("Courses")
                    }
                }
            } else {
                LoginView(authenticated: $authenticated)
            }
        }
        .onAppear() {
            authenticated = UserDefaults.standard.bool(forKey: "Authenticated")
        }
        .animation(.easeInOut)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
