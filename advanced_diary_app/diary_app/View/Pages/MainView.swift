//
//  Welcome.swift
//  diary_app
//
//  Created by Quentin Banet on 07/03/2025.
//

import SwiftUI

struct MainView: View {
    @Binding var selectedMenu: MenuOption
    
    @EnvironmentObject var authManager: AuthViewModel
    @EnvironmentObject var diary: Diary
    
    var body: some View {
        VStack {
            if !authManager.isLoggedIn {
                Text("Just click the button below to login.")
                    .font(.title3)
            } else {
                VStack {
                    if selectedMenu == .home {
                        DiaryView()
                    } else {
                        CalendarView()
                    }
                }
                .onAppear {
                    diary.fetchEntries()
                }
            }
        }
        .foregroundStyle(.white)
        .shadow(radius: 5)
    }
}

#Preview {
    MainView(selectedMenu: .constant(.home))
        .environmentObject(AuthViewModel())
        .environmentObject(Diary.preview)
}
