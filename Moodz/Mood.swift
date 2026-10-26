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

extension Date {
    /// Long date, 24-hour short time, e.g. "October 24, 2024 at 07:01"
    var moodString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "MMMM d, yyyy 'at' HH:mm"
        return formatter.string(from: self)
    }
}
