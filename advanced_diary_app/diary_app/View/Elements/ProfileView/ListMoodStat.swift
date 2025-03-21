//
//  ListMoodStat.swift
//  advanced_diary_app
//
//  Created by Quentin Banet on 20/03/2025.
//

import SwiftUI

struct ListMoodStat: View {
    @EnvironmentObject var diary : Diary
    
    @State private var isExpanded: Bool = true
    
    private var entriesCount: Int {
        diary.entries.count
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Your feel for your \(diary.entries.count) entries")
                    .font(.headline)
                    .padding()
                Spacer()
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                    Image(systemName: "chevron.down")
                        .rotationEffect(.degrees(isExpanded ? 0 : 180))
                        .animation(.easeInOut, value: isExpanded)
                        .padding()
                }
            }
            
            if isExpanded {
                VStack {
                    if diary.entries.isEmpty {
                        Text("No entries yet")
                            .font(.caption)
                    }
                    else {
                        ForEach(feelings.allCases, id: \.self) { mood in
                            MoodStatLine(mood: mood, percent: percent(for: mood))
                                .padding(.bottom, 15)
                                .padding(.horizontal)
                        }
                    }
                }
            }
        }
    }
    
    private func percent(for mood: feelings) -> Double {
        let moodCount = diary.entries.filter { $0.feeling == mood }.count
        if (moodCount == 0 || entriesCount == 0) {
            return 0
        }
        let res = (Double(moodCount) / Double(entriesCount)) * 100
        return res
    }
}

#Preview {
    ListMoodStat()
}
