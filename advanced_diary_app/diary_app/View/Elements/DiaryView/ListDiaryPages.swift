//
//  ListDiaryPages.swift
//  diary_app
//
//  Created by Quentin Banet on 17/03/2025.
//

import SwiftUI

struct ListDiaryPages: View {
    @EnvironmentObject var diary: Diary
    @State var showDetail: Bool = false
    @State private var selectedEntry: DiaryEntry? = nil

    var body: some View {
        VStack {
            if diary.entries.isEmpty {
                ButtonAddDiaryPage()
                Text("Create your first diary page!")
                    .foregroundColor(.gray)
                    .font(.headline)
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    ButtonAddDiaryPage()
                        .frame(maxWidth: .infinity)
                        .padding(.top)
                    
                    let groupedEntries = Dictionary(grouping: diary.entries.sorted(by: { $0.date > $1.date })) { entry in
                        Calendar.current.startOfDay(for: entry.date)
                    }

                    ForEach(groupedEntries.keys.sorted(by: >), id: \.self) { date in
                        VStack(alignment: .leading, spacing: 5) {
                            Text(formattedDate(date))
                                .font(.headline)
                                .padding(.horizontal)
                                .padding(.top)
                            
                            Divider()
                                .padding(.horizontal)
                            
                            ForEach(groupedEntries[date] ?? [], id: \.id) { entry in
                                Button(action: {
                                    selectedEntry = entry
                                }) {
                                    PageResume(entry: entry)
                                }
                                .sheet(item: $selectedEntry) { entry in
                                    PopupPageDetail(diaryPageId: entry.id, showSheet: Binding(
                                        get: { selectedEntry != nil },
                                        set: { if !$0 { selectedEntry = nil } }
                                    ))
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

func formattedDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .full
    return formatter.string(from: date)
}

struct ListDiaryPages_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            previewsWithEntry
            previewsWithoutEntry
        }
    }
    
    static var previewsWithEntry: some View {
        let authViewModel = AuthViewModel()
        authViewModel.signInTestUser()
        authViewModel.updateProfilePicture(url: "https://avatars.githubusercontent.com/u/86660998?v=4")

        return ZStack {
            Background()
            ListDiaryPages()
        }
        .environmentObject(Diary.preview)
        .environmentObject(authViewModel)
        .previewDisplayName( "With entry" )
    }
    
    static var previewsWithoutEntry: some View {
        let authViewModel = AuthViewModel()
        authViewModel.signInTestUser()
        authViewModel.updateProfilePicture(url: "https://avatars.githubusercontent.com/u/86660998?v=4")

        return ZStack {
            Background()
            ListDiaryPages()
        }
        .environmentObject(Diary())
        .environmentObject(authViewModel)
        .previewDisplayName("Without entry")
    }
}
