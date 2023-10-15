//
//  DiaryViewController.swift
//  Beam-swiftui
//
//  Created by Priya on 15/10/23.
//
import SwiftUI

struct DiaryViewController: View {
    @State private var date = Date()
    @State private var entries = [
        DiaryEntry(emotion: "Happy", content: "Had a great day!"),
        DiaryEntry(emotion: "Sad", content: "Feeling down today."),
        DiaryEntry(emotion: "Excited", content: "Looking forward to the weekend."),
        DiaryEntry(emotion: "Disappointed", content: "Things didn't go as expected.")
    ]

    @State private var isAddingEntry = false
    @State private var selectedEmotion: String = ""
    @State private var content = ""

    // Keep track of the selected entry for editing
    @State private var selectedEntry: DiaryEntry?

    var body: some View {
        NavigationView {
            VStack {
                DatePicker("", selection: $date, displayedComponents: .date)
                    .padding()

                List(entries, id: \.id) { entry in
                    Button(action: {
                        // Select the entry for editing
                        selectedEntry = entry
                        // Populate the AddEntryView fields with the selected entry's data
                        selectedEmotion = entry.emotion
                        content = entry.content
                        isAddingEntry = true
                    }) {
                        HStack {
                            Text(entry.emotion)
                                .foregroundColor(.white)
                                .padding(8)
                                .background(getEmotionColor(entry.emotion))
                                .cornerRadius(8)
                            Spacer()
                            Text(entry.firstSentence)
                        }
                    }
                    .listRowBackground(Color.white)
                }

                Spacer()
            }
            .navigationBarTitle("Diary")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button(action: {
                            isAddingEntry = true
                            // When creating a new entry, set selectedEntry to nil
                            selectedEntry = nil
                            selectedEmotion = DiaryEntry.emotions.first ?? ""
                            content = ""
                        }) {
                            Image(systemName: "square.and.pencil")
                                .font(.system(size: 18))
                                .foregroundColor(Color.orange)
                        }
                        Button(action: {
                            // Handle the user account action
                        }) {
                            Image(systemName: "person.circle")
                                .font(.system(size: 18))
                                .foregroundColor(Color.orange)
                        }
                    }
                }
            }
            .sheet(isPresented: $isAddingEntry) {
                AddEntryView(isPresented: $isAddingEntry, entries: $entries, selectedEmotion: $selectedEmotion, content: $content, selectedEntry: $selectedEntry)
            }
        }
    }
}

struct DiaryViewController_Previews: PreviewProvider {
    static var previews: some View {
        DiaryViewController()
    }
}

struct DiaryEntry: Identifiable {
    let id = UUID()
    var emotion: String
    var content: String

    var firstSentence: String {
        return content.components(separatedBy: ".")[0]
    }

    static let emotions: [String] = ["😊 Happy", "😢 Sad", "😃 Excited", "😞 Disappointed"]
}

func getEmotionColor(_ emotion: String) -> Color {
    switch emotion {
    case "Happy":
        return Color.green
    case "Sad":
        return Color.blue
    case "Excited":
        return Color.orange
    case "Disappointed":
        return Color.red
    default:
        return Color.black
    }
}

struct AddEntryView: View {
    @Binding var isPresented: Bool
    @Binding var entries: [DiaryEntry]
    @Binding var selectedEmotion: String
    @Binding var content: String
    // Add a binding to the selected entry
    @Binding var selectedEntry: DiaryEntry?
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("New Entry")) {
                    Picker("Emotion", selection: $selectedEmotion) {
                        ForEach(DiaryEntry.emotions, id: \.self) { emotion in
                            Text(emotion)
                        }
                    }
                    
                    TextEditor(text: $content)
                        .frame(height: 200)
                }
            }
            .navigationBarTitle("Add Entry")
            .navigationBarItems(
                leading: Button("Cancel") {
                    isPresented = false
                },
                trailing: Button("Save") {
                    if !selectedEmotion.isEmpty && !content.isEmpty {
                        if var entry = selectedEntry { // If we have a selected entry
                            entry.emotion = selectedEmotion
                            entry.content = content
                        } else { // If it's a new entry
                            let newEntry = DiaryEntry(emotion: selectedEmotion, content: content)
                            entries.append(newEntry)
                        }
                        isPresented = false
                    }
                }
            )
        }
    }
}
