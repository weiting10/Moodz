import SwiftUI
import SwiftData

@main
struct MoodzApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Mood.self)
    }
}
