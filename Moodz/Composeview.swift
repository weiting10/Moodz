import SwiftUI
import SwiftData

struct ComposeView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var mood: MoodType = .ok
    @State private var title = ""
    @State private var text = ""

    var body: some View {
        // The Save button sits outside the Form, so it stays put while the form scrolls.
        VStack(spacing: 0) {
            Form {
                Section {
                    Picker("Mood", selection: $mood) {
                        ForEach(MoodType.allCases) { type in
                            Text("\(type.emoji()) \(type.description())").tag(type)
                        }
                    }
                    .pickerStyle(.wheel)
                } header: {
                    Text("\(mood.emoji()) \(mood.description())")
                        .font(.headline)
                }

                Section("Title") {
                    TextField("What's on your mind?", text: $title)
                }

                Section("Notes") {
                    TextEditor(text: $text)
                        .frame(minHeight: 120)
                }
            }

            Button {
                save()
            } label: {
                Text("Save")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 6)
            }
            .buttonStyle(.borderedProminent)
            .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
            .padding()
            .background(.bar)
        }
    }

    private func save() {
        let entry = Mood(title: title, text: text, mood: mood)
        modelContext.insert(entry)
        dismiss()
    }
}

#Preview {
    ComposeView()
        .modelContainer(for: Mood.self, inMemory: true)
}
