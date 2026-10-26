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
                Section("Title") {
                    TextField("What's on your mind?", text: $title)
                }

                Section("Text") {
                    TextEditor(text: $text)
                        .frame(minHeight: 300)
                }

                Section {
                    Picker("Mood", selection: $mood) {
                        ForEach(MoodType.allCases) { type in
                            Text(type.emoji()).tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Mood")
                }
            }

            Button {
                save()
            } label: {
                Text("Save")
                    .font(.headline)
                    .frame(maxWidth: 80)
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
