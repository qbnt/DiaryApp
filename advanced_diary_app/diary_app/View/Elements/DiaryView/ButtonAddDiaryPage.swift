//
//  AddDiaryPage.swift
//  diary_app
//
//  Created by Quentin Banet on 17/03/2025.
//

import SwiftUI

struct ButtonAddDiaryPage: View {
    @EnvironmentObject var diary: Diary
    @State private var showSheet = false
    
    var body: some View {
        Button(action: {
            showSheet.toggle()
        }) {
            ZStack {
                if !diary.entries.isEmpty {
                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .foregroundStyle(.gray.opacity(0.8))
                        .opacity(0.4)
                } else {
                    Circle()
                        .frame(width: 70, height: 70)
                        .foregroundStyle(.gray.opacity(0.8))
                        .opacity(0.4)
                }
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(.white)
            }
        }
        .popover(isPresented: $showSheet) {
            PopupPageInput(showSheet: $showSheet)
        }
    }
}

struct ButtonAddDiaryPage_Previews: PreviewProvider {
    static var previews: some View {
        let authViewModel = AuthViewModel()
        authViewModel.signInTestUser()
        authViewModel.updateProfilePicture(url: "https://avatars.githubusercontent.com/u/86660998?v=4")

        return ZStack {
            Background()
            ButtonAddDiaryPage()
        }
        .environmentObject(Diary())
        .environmentObject(authViewModel)
    }
}
