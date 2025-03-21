//
//  ListDiaryPageMini.swift
//  advanced_diary_app
//
//  Created by Quentin Banet on 20/03/2025.
//

import SwiftUI

struct ListDiaryPagesMini: View {
    @EnvironmentObject var diary: Diary
    @State var showDetail: Bool = false
    @State private var selectedEntry: DiaryEntry? = nil
    @State private var isExpanded: Bool = true

    var body: some View {
        VStack {
            HStack {
                Text("Last Diary Entries")
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
                if diary.entries.isEmpty {
                    Text("Create your first diary page!")
                        .foregroundColor(.gray)
                        .font(.callout)
                    ButtonAddDiaryPage()
                } else {
                    ButtonAddDiaryPage()
                        .frame(maxWidth: .infinity)
                    
                    ForEach(diary.entries.sorted(by: { $0.date > $1.date }).prefix(2), id: \.id) { entry in
                        Button(action: {
                            selectedEntry = entry
                        }) {
                            PageResume(entry: entry)
                        }
                        .onAppear {
                            diary.fetchEntries()
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

struct ListDiaryPagesMini_Previews: PreviewProvider {
    
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
            ListDiaryPagesMini()
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
            ListDiaryPagesMini()
        }
        .environmentObject(Diary())
        .environmentObject(authViewModel)
        .previewDisplayName("Without entry")
    }
}
