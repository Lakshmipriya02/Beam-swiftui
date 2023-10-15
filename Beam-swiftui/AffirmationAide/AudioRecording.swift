//
//  AudioRecording.swift
//  Beam-swiftui
//
//  Created by Advikaa Ramesh on 15/10/23.
//

import Foundation

struct AudioRecording: Identifiable {
    let id = UUID()
    let title: String
    let audioURL: URL?
}
