//
//  MoodStatLine.swift
//  advanced_diary_app
//
//  Created by Quentin Banet on 20/03/2025.
//

import SwiftUI

struct MoodStatLine: View {
    var mood: feelings
    var percent: Double

    var body: some View {
        GeometryReader { geometry in
            let maxWidth = geometry.size.width
            let emojiRatio: CGFloat = 0.1
            let percentRatio: CGFloat = 0.15
            let barRatio: CGFloat = 1.0 - emojiRatio - percentRatio - 0.05

            let emojiWidth = maxWidth * emojiRatio
            let percentWidth = maxWidth * percentRatio
            let barMaxWidth = maxWidth * barRatio
            let barWidth = min(barMaxWidth, barMaxWidth * (percent / 100))

            HStack {
                Text(mood.emoji)
                    .frame(width: emojiWidth, alignment: .leading)
                Rectangle()
                    .frame(width: barWidth, height: 20, alignment: .leading)
                    .foregroundStyle(.secondary)
                    .cornerRadius(30)
                Spacer(minLength: 8)
                Text("\(Int(percent)) %")
                    .frame(width: percentWidth, alignment: .trailing)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    MoodStatLine(mood: feelings.love, percent: 80)
}
