//
//  PopupPageDetail.swift
//  diary_app
//
//  Created by Quentin Banet on 17/03/2025.
//

import SwiftUI

struct PopupPageDetail: View {
    @EnvironmentObject var diary: Diary

    var diaryPageId: UUID
    @Binding var showSheet: Bool

    private var diaryPage: DiaryEntry? {
        diary.entries.first(where: { $0.id == diaryPageId })
    }

    var body: some View {
        ZStack {
            Background()
            if diaryPage != nil {
                VStack(alignment: .leading, spacing: 20) {
                    Text(diaryPage!.title)
                        .font(.title)
                        .bold()
                        .padding(.top)
                    
                    Divider()
                    
                    HStack {
                        Text(diaryPage!.date, style: .date)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(diaryPage!.feeling.rawValue)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(diaryPage!.feeling.emoji)
                            .font(.largeTitle)
                    }
                    
                    Text(diaryPage!.text)
                        .font(.body)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.gray.opacity(0.2))
                        .cornerRadius(30)
                    Spacer()
                    
                    ButtonDeletePage(pageId: diaryPageId, showSheet: $showSheet)
                }
                .foregroundStyle(.primary)
                .padding()
            } else {
                Text("No entry")
                    .onAppear {
                        showSheet.toggle()                        
                    }
            }
        }
    }
}

#Preview {
    @Previewable @State var showSheet: Bool = true

    let mockDiary = Diary()
    let mockEntry = DiaryEntry(
        username: "TestUser",
        date: Date(),
        title: "Une journée incroyable",
        feeling: feelings.joy,
        text: "Aujourd'hui, j'ai fait une super randonnée et j'ai découvert un superbe spot pour prendre des photos."
    )
    
    mockDiary.entries.append(mockEntry)

    return PopupPageDetail(
        diaryPageId: mockEntry.id,
        showSheet: $showSheet
    )
    .environmentObject(mockDiary)
}
