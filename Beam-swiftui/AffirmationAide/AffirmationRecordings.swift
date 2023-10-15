//
//  AffirmationRecordings.swift
//  Beam-swiftui
//
//  Created by Advikaa Ramesh on 15/10/23.
//

import SwiftUI
import AVFoundation

struct AffirmationRecordings: View {
    @ObservedObject var audioPlayer: AudioPlayer
    @State private var isRecording = false
    @State private var audioRecorder: AVAudioRecorder?
 
    
        var body: some View {
            VStack {
                Button(action: {
                    if isRecording {
                        stopRecording()
                    } else {
                        startRecording()
                    }
                }) {
                    Image(systemName: isRecording ? "stop.circle.fill." : "play.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 70)
                        .foregroundColor(isRecording ? .orange : .orange)
                        
                            }
            }
            .navigationBarTitle("Recording Affirmations")
            .padding(.top, 500)
        }

        private func startRecording() {
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setCategory(.record, mode: .default)
                try audioSession.setActive(true)
                let audioSettings: [String: Any] = [
                    AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                    AVSampleRateKey: 44100.0,
                    AVNumberOfChannelsKey: 2,
                    AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
                ]
                audioRecorder = try AVAudioRecorder(url: audioFilePath(), settings: audioSettings)
                audioRecorder?.prepareToRecord()
                audioRecorder?.record()
                isRecording = true
            } catch {
                print("Error starting recording: \(error)")
            }
        }

    private func stopRecording() {
        audioRecorder?.stop()
        isRecording = false
        if let audioURL = audioRecorder?.url {
            audioPlayer.saveRecording(url: audioURL)
        }
        audioRecorder = nil
    }




        private func audioFilePath() -> URL {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let filename = "my_recording.m4a" // You can use a unique filename
            return documentsDirectory.appendingPathComponent(filename)
        }
}

#Preview {
    AffirmationRecordings(audioPlayer: AudioPlayer())
}
