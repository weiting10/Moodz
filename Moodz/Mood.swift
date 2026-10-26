import Foundation
import SwiftData

@Model
final class Mood {
    var title: String
    var text: String
    var timestamp: Date
    private var moodValue: Int

    /// Stored as an Int, exposed as MoodType.
    var mood: MoodType {
        get { MoodType(moodValue) }
        set { moodValue = newValue.rawValue }
    }

    init(title: String, text: String, mood: MoodType, timestamp: Date = .now) {
        self.title = title
        self.text = text
        self.timestamp = timestamp
        self.moodValue = mood.rawValue
    }
}
