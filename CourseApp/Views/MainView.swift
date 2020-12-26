//
//  MainView.swift
//  CourseApp
//
//  Created by Sean.S.Nguyen on 26/9/20.
//  Copyright © 2020 Sean.S.Nguyen. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @Binding var showProfile: Bool
    @State var minX: Double = 0
    @State var showModal: Bool = false
    @State var showUpcoming: Bool = false
    @State var showCertificate: Bool = false
    
    let courses = [
        CourseData(title: "GCP Certificate", logo: Image("Logo1"), sections: "15 sections", image: Image("Card1"), color: Color("card1")),
        CourseData(title: "AWS Certificate", logo: Image("Logo2"), sections: "19 sections", image: Image("Card2"), color: Color("card2")),
        CourseData(title: "Java Certificate", logo: Image("Logo3"), sections: "5 sections", image: Image("Card4"), color: Color("card4"))
    ]
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
    //            Text("minX: \(minX)")
                HStack {
                    Text("Learning").font(.system(size: 28)).fontWeight(.bold)
                    Spacer()
                    AvatarView(showProfile: $showProfile)
                    Button(action: { self.showModal.toggle() }) {
                        Circle()
                            .frame(width: 45, height: 45)
                            .foregroundColor(Color("background3"))
                            .overlay(
                                ZStack {
                                    Image(systemName: "bell")
    //                                    .renderingMode(.original)
                                        .foregroundColor(.primary)
                                        .aspectRatio(contentMode: .fill)
                                    VStack {
                                        Spacer()
                                        HStack {
                                            Spacer()
                                            Text("3")
                                                .foregroundColor(.white)
                                                .font(.system(size: 11)).bold()
                                                .frame(width: 15, height: 15)
                                                .background(Color.red)
                                                .clipShape(Circle())
                                        }
                                    }
//                                    .clipShape(Circle())
                                }
                                
                            )
                            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 10)
                    }
                    .sheet(isPresented: $showModal, content: { CourseListView() })
                }
                .padding()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 30) {
                        ForEach(courses) { course in
                            GeometryReader { geometry in
                                self.useProxy(geometry, course: course)
                            }
                            .onTapGesture {
                                withAnimation{
                                    self.showCertificate = true
                                }
                            }
                            .frame(width: 275, height: 375)
                            
                        }
                    }
                    .padding(10)
                }
                
                HStack {
                    Text("Upcoming Courses").font(.system(size: 28)).fontWeight(.bold)
                    Spacer()
                }
                .padding()

                GeometryReader { geometry in
                    UpcomingCourseView(showUpcoming: $showUpcoming)
                        .frame(width: screen.width, height: showUpcoming ? screen.height : 200)
                        .offset(y: showUpcoming ? -geometry.frame(in: .global).minY : 0)
                }
                
                Spacer()
            }
        }
            .statusBar(hidden: showUpcoming)
            .opacity(showCertificate ? 0 : 1)
        
        if showCertificate {
            ZStack {
                ContentView()
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "xmark")
                            .padding()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .clipShape(Circle())
                            .onTapGesture {
                                withAnimation{
                                    self.showCertificate = false
                                }
                            }
                    }
                    Spacer()
                }
                .padding()
            }
        }
    }
    
    func useProxy(_ geometry: GeometryProxy, course: CourseData) -> some View {
        let rotation = Double(geometry.frame(in: .global).minX / (-20))
        
        // modifying state during view update, this will cause undefined behavior
//        self.minX = rotation

        return CourseView(courseData: course)
                .rotation3DEffect(.degrees(rotation), axis: (0, 10 ,0))
    }
}



struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(showProfile: .constant(false))
    }
}

struct AvatarView: View {
    
    @Binding var showProfile: Bool

    var body: some View {
        Button(action: {
            self.showProfile.toggle()
        }, label: {
            Image("Logo1")
                .renderingMode(.original)
                .resizable()
                .frame(width: 45, height: 45)
            
        })
    }
}

struct CourseView: View {
    
    var courseData: CourseData
    var progress = true
    
    var body: some View {
        VStack {
            if progress {
                HStack {
                    ProgressRingView(color1: Color(UIColor.random), color2: Color(UIColor.random), size: 44, percentage: courseData.randomPercentage, show: true)
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Text("\(courseData.randomLeft)hr(s) left")
                            .fontWeight(.bold)
                        Text("Watch \(courseData.randomWatched)hr(s) today")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                        .padding(3)
                }
                    .roundedRectangleShadowModifiers()
            }
            
            VStack {
                HStack(alignment: .top) {
                    Text(courseData.title)
                        .font(.system(size: 24, weight: .bold))
                        .frame(width: 160, alignment: .leading)
                        .foregroundColor(Color.white)
                    
                    Spacer()
                    
                    courseData.logo
                }
                .padding()
                
                Text(courseData.sections.uppercased())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 30)
                    .padding(.horizontal)
                    .foregroundColor(Color.white)
                
                Spacer()
                
                courseData.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 210)
            }
            .background(courseData.color)
            .cornerRadius(30)
            .shadow(color: courseData.color.opacity(0.4), radius: 5, x: 0, y: 3)
        }
    }
}

struct CourseData: Identifiable {
    var id = UUID()
    var title: String
    var logo: Image
    var sections: String
    var image: Image
    var color: Color
    let randomLeft = Int.random(in: 1..<5)
    let randomWatched = Int.random(in: 1..<5)
    let randomPercentage = CGFloat.random(in: 1..<90)
}

extension UIColor {
    static var random: UIColor {
            return UIColor(
                red: .random(in: 0...1),
               green: .random(in: 0...1),
               blue: .random(in: 0...1),
               alpha: 1.0
            )
        }
}
