//
//  ListSelectedDate.swift
//  advanced_diary_app
//
//  Created by Quentin Banet on 21/03/2025.
//

import SwiftUI

struct ListSelectedDate: View {
    @EnvironmentObject var diary: Diary
    @Binding var selectedDate: Date
    
    @State private var selectedEntry: DiaryEntry? = nil
    @State private var showEntrySheet: Bool = false

    private var dayEntry: [DiaryEntry] {
        diary.entries.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
    }

    var body: some View {
        if dayEntry.isEmpty {
            Spacer()
            Text("No entries for this day")
                .foregroundColor(.secondary)
                .font(.title3)
                .padding(.bottom, 10)
            Spacer()
        } else {
            ScrollView {
                ForEach(dayEntry.sorted(by: { $0.date > $1.date })) { entry in
                    Button(action: {
                        selectedEntry = entry
                        showEntrySheet = true
                    }) {
                        PageResume(entry: entry)
                    }
                }
                .padding(.bottom, 3)
            }
            .sheet(isPresented: $showEntrySheet) {
                if let entry = selectedEntry {
                    PopupPageDetail(diaryPageId: entry.id, showSheet: $showEntrySheet)
                }
            }
            .padding(.bottom, 10)
        }
    }
}

#Preview {
    @Previewable @State var selectedDate: Date = Date()
    ListSelectedDate(selectedDate: $selectedDate)
}
