//
//  DiaryView.swift
//  diary_app
//
//  Created by Quentin Banet on 17/03/2025.
//

import SwiftUI

struct DiaryView: View {
    @EnvironmentObject var diary: Diary
    @EnvironmentObject var authManager: AuthViewModel
    
    var body: some View {
        VStack {
            if diary.entries.isEmpty || !authManager.isLoggedIn {
                Text("Welcome to your diary!")
                    .font(.title)
                    .bold()
            }
            
            ListDiaryPages()
                .padding(.vertical)
        }
    }
}

struct DiaryView_Previews: PreviewProvider {
    static var previews: some View {
        let authViewModel = AuthViewModel()
        authViewModel.signInTestUser()
        authViewModel.updateProfilePicture(url: "https://avatars.githubusercontent.com/u/86660998?v=4")

        return ZStack {
            Background()
            DiaryView()
        }
        .environmentObject(Diary.preview)
        .environmentObject(authViewModel)
    }
}
