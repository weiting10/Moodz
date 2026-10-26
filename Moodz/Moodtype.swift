import Foundation

enum MoodType: Int, Codable, CaseIterable, Identifiable {
    case crappy, meh, ok, happy, ecstatic

    var id: Int { rawValue }

    /// Falls back to `.ok` for out-of-range values.
    init(_ value: Int) {
        self = MoodType(rawValue: value) ?? .ok
    }

    func description() -> String {
        switch self {
        case .crappy:   return "Crappy"
        case .meh:      return "Meh"
        case .ok:       return "OK"
        case .happy:    return "Happy"
        case .ecstatic: return "Ecstatic"
        }
    }

    func emoji() -> String {
        switch self {
        case .crappy:   return "😞"
        case .meh:      return "😕"
        case .ok:       return "😊"
        case .happy:    return "😃"
        case .ecstatic: return "😄"
        }
    }
}
