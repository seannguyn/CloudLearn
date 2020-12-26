//
//  UpdateStore.swift
//  CourseApp
//
//  Created by Sean.S.Nguyen on 27/9/20.
//  Copyright © 2020 Sean.S.Nguyen. All rights reserved.
//

import Foundation
import Combine

class UpdateStore: ObservableObject {
    @Published var updates: [Update] = [
        Update(image: "Card1", title: "New Course: Azure", text: "Course Debut 1/2021", date: "JAN 1"),
        Update(image: "Card2", title: "Promotion", text: "50% off in January. New year new you", date: "DEC 24"),
        Update(image: "Card3", title: "Achievement", text: "Consecutive days of learning unlocked", date: "AUG 27")
    ]
}

struct Update: Identifiable {
    var id = UUID()
    var image: String
    var title: String
    var text: String
    var date: String
}
