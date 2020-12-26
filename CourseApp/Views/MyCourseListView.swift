//
//  MyCourseListView.swift
//  CourseApp
//
//  Created by Sean.S.Nguyen on 26/12/20.
//  Copyright © 2020 Sean.S.Nguyen. All rights reserved.
//

import SwiftUI

struct MyCourseListView: View {
    
    @State var courses:[MyCourse] = [
        MyCourse(title: "Salesforce Lab", sections: "5 Sections", logo: Image(uiImage: #imageLiteral(resourceName: "Logo1")), theme: Image(uiImage: #imageLiteral(resourceName: "Card4"))),
        MyCourse(title: "C# Master", sections: "6 Sections", logo: Image(uiImage: #imageLiteral(resourceName: "fingerprint")), theme: Image(uiImage: #imageLiteral(resourceName: "Card3"))),
        MyCourse(title: "Node Advanced", sections: "9 Sections", logo: Image(uiImage: #imageLiteral(resourceName: "Logo2")), theme: Image(uiImage: #imageLiteral(resourceName: "Card2")))
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                HStack {
                    Text("Courses").font(.system(size: 30, weight: .bold))
                    Spacer()
                }
                .padding(.horizontal, 30)
                
                ForEach(0..<courses.count) { index in
                    GeometryReader { geometry in
                        MyCourseView(show: $courses[index].show, course: courses[index])
                            .offset(y: courses[index].show ? -geometry.frame(in: .global).minY : 0)
                    }
                    .frame(height: courses[index].show ? screen.height : 280)
                    .frame(maxWidth: courses[index].show ? .infinity : screen.width - 60)
                }
            }
            .frame(width: screen.width)
        }
    }
}

struct MyCourseView: View {
    
    @Binding var show: Bool
    var course: MyCourse
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(course.title)
                            .font(.system(size: 26, weight: .bold))
                            .foregroundColor(Color.white)
                        Text(course.sections)
                            .foregroundColor(.black).opacity(0.7)
                    }
                    Spacer()
                    ZStack {
                        Image(uiImage: #imageLiteral(resourceName: "Logo1"))
                            .opacity(show ? 0 : 1)
                        
                        Image(systemName: "xmark")
                            .padding()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .clipShape(Circle())
                            .opacity(show ? 1 : 0)
                            .onTapGesture {
                                self.show = false
                            }
                            
                    }
                }
                Image(uiImage: #imageLiteral(resourceName: "Card4"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                if show {
                    VStack(spacing: 20) {
                        Text("Learn about Azure Cloud and receive advice from professionals")
                        Text("About this course")
                            .font(.title)
                            .bold()
                        Text("Get 12-Months Of Popular Products Incl. Computer, Storage, Database & Networking. Build Your Next Idea. Start with a Free Credit. 25+ Products Always Free. Try Popular Products Free. Learn by Doing. Types: Networking, Developer Tools, Data + Analytics")
                    }
                    .padding()
                    .foregroundColor(.black)
                    .frame(alignment: .leading)
                }
            }
                .padding(20)
                .padding([.top], show ? 30: 0)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? .infinity : 280, alignment: .top)
            .background(course.color)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(color: .black, radius: 7.5, x: 0.0, y: 0.0)
                .onTapGesture {
                    self.show = true
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: show ? .top : .center)
            .animation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0))
            .edgesIgnoringSafeArea(.all)
    }
}

struct MyCourseListView_Previews: PreviewProvider {
    static var previews: some View {
        MyCourseListView()
    }
}

struct MyCourse {
    var title: String
    var sections: String
    var logo: Image
    var theme: Image
    var show: Bool = false
    var color = Color(UIColor.random)
}
