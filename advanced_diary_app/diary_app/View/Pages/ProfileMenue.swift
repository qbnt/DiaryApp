//
//  ProfileMenue.swift
//  diary_app
//
//  Created by Quentin Banet on 17/03/2025.
//

import SwiftUI
import FirebaseAuth

struct ProfileMenue: View {
    var profile: User
    var body: some View {
        ZStack {
            Background()
            VStack() {
                UserData(profile: profile)
                    .padding(.top)
                Divider()
                    .padding(.top)
                ScrollView() {
                    ListDiaryPagesMini()
                    ListMoodStat()
                }
                Divider()
                    .padding(.bottom)
                LogoutButton()
                    .shadow(radius: 10)
                    .padding(.bottom, 30)
            }
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray.opacity(0.1))
        }
    }
}

struct ProfileMenue_Previews: PreviewProvider {
    static var previews: some View {
        let authViewModel = AuthViewModel()
        authViewModel.signInTestUser()
        authViewModel.updateProfilePicture(url: "https://avatars.githubusercontent.com/u/86660998?v=4")
        
        return ProfileMenue(profile: authViewModel.user!)
            .environmentObject(Diary.preview)
    }
}
