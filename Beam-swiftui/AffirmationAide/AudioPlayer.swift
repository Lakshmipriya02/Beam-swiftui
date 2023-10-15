//
//  AudioPlayer.swift
//  Beam-swiftui
//
//  Created by Advikaa Ramesh on 15/10/23.
//

import Foundation
import AVFoundation

class AudioPlayer: ObservableObject {
    private var audioPlayer: AVAudioPlayer?
    @Published var recordings: [AudioRecording] = []
    @Published var affirmationCount: Int = 0

    func togglePlayback(for recording: AudioRecording) {
        if isPlaying(recording) {
            stopAudio()
        } else {
            if let audioURL = recording.audioURL {
                playAudio(at: audioURL)
            }
        }
    }

    func isPlaying(_ recording: AudioRecording) -> Bool {
        if let audioPlayer = audioPlayer, let audioURL = recording.audioURL, audioPlayer.isPlaying && audioPlayer.url == audioURL {
            return true
        }
        return false
    }

    func playAudio(at url: URL) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()  // Add this line to prepare the audio player
            audioPlayer?.play()
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
    func saveRecording(url: URL) {
            let title = "Affirmation \(affirmationCount + 1)"
            let recording = AudioRecording(title: title, audioURL: url)
            recordings.append(recording)
            affirmationCount += 1
        }


    func stopAudio() {
        audioPlayer?.stop()
    }
}
