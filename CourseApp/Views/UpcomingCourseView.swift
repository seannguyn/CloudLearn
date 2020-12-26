//
//  UpcomingCourseView.swift
//  CourseApp
//
//  Created by Sean.S.Nguyen on 25/12/20.
//  Copyright © 2020 Sean.S.Nguyen. All rights reserved.
//

import SwiftUI

struct UpcomingCourseView: View {
    var courseData = CourseData(title: "Azure Lab", logo: Image("Logo3"), sections: "20 sections", image: Image("Card3"), color: Color("card3"))
    
    @Binding var showUpcoming: Bool
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 30) {
                Text("Learn about Azure Cloud and receive advice from professionals")
                Text("About this course")
                    .font(.title)
                    .bold()
                Text("Get 12-Months Of Popular Products Incl. Computer, Storage, Database & Networking. Build Your Next Idea. Start with a Free Credit. 25+ Products Always Free. Try Popular Products Free. Learn by Doing. Types: Networking, Developer Tools, Data + Analytics")
            }
                .padding(30)
                .background(Color("background1"))
                .cornerRadius(showUpcoming ? 0 : 30)
                .frame(maxWidth: showUpcoming ? .infinity : screen.width - 60, maxHeight: showUpcoming ? .infinity : 275, alignment: .top)
                .offset(y: showUpcoming ? 480 : 0)
            
            VStack {
                HStack(alignment: .top) {
                    Text(courseData.title)
                        .font(.system(size: 24, weight: .bold))
                        .frame(width: 160, alignment: .leading)
                        .foregroundColor(Color.white)
                    
                    Spacer()
                    
                    ZStack {
                        Image(systemName: "xmark")
                            .padding()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .clipShape(Circle())
                            .onTapGesture {
                                showUpcoming = false
                            }
                            .opacity(showUpcoming ? 1 : 0)
                        courseData.logo
                            .opacity(showUpcoming ? 0 : 1)
                    }
                }
                .padding([.top], showUpcoming ? 30 : 0)
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
            .frame(maxWidth: showUpcoming ? .infinity : screen.width - 60, maxHeight: showUpcoming ? 500 : 275)
            .onTapGesture {
                self.showUpcoming = true
            }
        }
            .animation(.spring(response: 0.5, dampingFraction: 0.9, blendDuration: 0))
            .edgesIgnoringSafeArea(.all)
            
    }
}

//struct UpcomingCourseView_Previews: PreviewProvider {
//    static var previews: some View {
//        UpcomingCourseView()
//    }
//}
