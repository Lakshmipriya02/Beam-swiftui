//
//  AffirmationEntries.swift
//  Beam-swiftui
//
//  Created by Advikaa Ramesh on 15/10/23.
//

import SwiftUI
import AVFoundation

struct AffirmationEntries: View {
    @State private var selectedDate = Date()
    @State private var isButtonVisible = true
    @StateObject private var audioPlayer = AudioPlayer()
    @State private var isRecordingScreenPresented = false
    
    var body: some View {
        
        NavigationView {
            VStack {
                DatePicker("", selection: $selectedDate,in: ...Date(), displayedComponents: .date)
                    .foregroundColor(.orange)
                    .padding(.horizontal)
       
                List {
                    ForEach(audioPlayer.recordings) { recording in
                        HStack {
                            Button(action: {
                                audioPlayer.togglePlayback(for: recording)
                            }) {
                                let isPlaying = audioPlayer.isPlaying(recording)
                                let buttonImageName = isPlaying ? "stop.fill" : "play.circle.fill"
                                
                                Image(systemName: buttonImageName)
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.orange)
                            }
                            
                            Text(recording.title)
                                .font(.system(size: 18))
                                .foregroundColor(.orange)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 10) // Adjust the radius as needed
                                .foregroundColor(Color(red: 1.0, green: 0.9, blue: 0.85)) // Cell background color
                        )
                    }
                }

                .listStyle(GroupedListStyle())
                .padding()
                
                
            }
            .navigationBarTitle("Affirmations")
            .navigationBarItems(trailing:
                                    Button(action: {
                isRecordingScreenPresented.toggle()
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 22))
                    .foregroundColor(.orange)
            }
            )
        }
        .sheet(isPresented: $isRecordingScreenPresented) {
            NavigationView {
                AffirmationRecordings( audioPlayer: audioPlayer)
                    .navigationBarTitle("Recording Affirmation")
                    .navigationBarItems(leading:
                        Button(action: {
                            isRecordingScreenPresented = false
                        }) {
                            Image(systemName: "chevron.left")
                                
                        }
                    )
            }
        }

        .overlay(
            Group {
                if audioPlayer.recordings.isEmpty {
                    VStack {
                        Button(action: {
                            isRecordingScreenPresented.toggle()
                        }) {
                            Image(systemName: "plus.circle")
                                .font(.system(size: 100))
                                .foregroundColor(.orange)
                                .padding(.bottom, 20)
                        }
                        
                        Text("Have something to say?\nRecord an affirmation now!")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom, 0)
                            .foregroundColor(.orange)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 20))
                    }
                }
            }
        )
    }
}

#Preview {
    AffirmationEntries()
}
