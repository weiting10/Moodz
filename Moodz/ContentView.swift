import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Mood.timestamp) private var moods: [Mood]

    @State private var showCompose = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(moods) { mood in
                    NavigationLink {
                        MoodView(mood: mood)
                    } label: {
                        HStack(spacing: 14) {
                            Text(mood.mood.emoji())
                                .font(.title2)
                            VStack(alignment: .leading, spacing: 2) {
                                Text(mood.title)
                                    .font(.title3)
                                // long date / 24-hour time, e.g. "October 24, 2024 at 07:01"
                                Text(mood.timestamp.moodString)
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Moodz")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showCompose = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showCompose) {
                ComposeView()
            }
        }
        .tint(.blue)
    }

    private func delete(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(moods[index])
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Mood.self, inMemory: true)
}
