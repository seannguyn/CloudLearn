//
//  CourseList.swift
//  CourseApp
//
//  Created by Sean.S.Nguyen on 26/9/20.
//  Copyright © 2020 Sean.S.Nguyen. All rights reserved.
//

import SwiftUI

struct CourseListView: View {
    
    @ObservedObject var viewModel = UpdateStore()
    
    func addUpdates() {
        viewModel.updates.insert(Update(image: "Card1", title: "New Item", text: "New Item Text", date: "1 Jan"), at: 0)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.updates) { course in
                    NavigationLink(destination: UpdateView(update: course)) {
                        HStack {
                            Image(course.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 90, height: 90)
                                .background(Color.black)
                                .cornerRadius(20)
                                .padding(.trailing, 10)
                                .padding(.top, 10)
                                .padding(.bottom, 10)
                            
                            VStack(spacing: 8) {
                                Text(course.title)
                                    .font(.system(size: 20, weight: .bold))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                Text(course.text)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .lineLimit(2)
                                
                                Text(course.date)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(Color.secondary)
                                    .font(.system(size: 15, weight: .bold))
                            }
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                        }
                        
                    }
                }
                .onDelete { index in
                    self.viewModel.updates.remove(at: index.first!)
                }
                .onMove { (source: IndexSet, destination: Int) in
                    self.viewModel.updates.move(fromOffsets: source, toOffset: destination)
                }
            }
            .navigationBarTitle("Notification")
//            .navigationBarItems(leading: Button(action: {
//                self.addUpdates()
//            }, label: {
//                Text("Add")
//            }), trailing: EditButton())
        }
    }
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseListView()
    }
}
