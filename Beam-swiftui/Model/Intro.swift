//
//  Intro.swift
//  Beam-swiftui
//
//  Created by Advikaa Ramesh on 15/10/23.
//

import Foundation

struct Intro: Identifiable{
    var id: String = UUID().uuidString
    var imageName: String
    var title: String
}
var intros: [Intro] = [
    .init(imageName: "selflove_ob", title: "Love Yourself"),
    .init(imageName: "Meditation_onboarding", title: "Take a Breath"),
    .init(imageName: "therapist_ob", title: "Talk to a Professional")
]
