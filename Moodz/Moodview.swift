import SwiftUI

struct MoodView: View {
    let mood: Mood

    var body: some View {
        VStack(spacing: 16) {
            // Card: a ZStack clipped with .mask.
            // To use a real image as the background, add an image to Assets
            // (e.g. "moodBackground") and replace the Rectangle with
            // Image("moodBackground").resizable().scaledToFill()
            ZStack {
                Rectangle()
                    .fill(.quaternary)

                VStack(spacing: 0) {
                    Text(mood.mood.emoji())
                        .font(.system(size: 130))
                    Text(mood.mood.description())
                        .font(.title)
                        .foregroundStyle(.secondary)
                }
            }
            .frame(height: 200)
            .mask(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal)

            Text(mood.title)
                .font(.title3)

            Text(mood.text)
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 28)

            Spacer()

            Text(mood.timestamp.moodString)
                .font(.caption2)
                .foregroundStyle(.tertiary)
                .padding(.bottom, 24)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        MoodView(mood: Mood(title: "Yeah 💕❤️😂🙈",
                            text: "I have no words. This is the best day of my life. No - seriously. And it rained since this morning ...",
                            mood: .ecstatic))
    }
}
