//
//  UserData.swift
//  advanced_diary_app
//
//  Created by Quentin Banet on 20/03/2025.
//

import SwiftUI
import FirebaseAuth
import Kingfisher

struct UserData: View {
    var profile: User
    var body: some View {
        HStack {
            KFImage(profile.photoURL)
                .resizable()
                .frame(width: 100, height: 100)
                .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.white, lineWidth: 10))
                .cornerRadius(30)
            Spacer()
            Divider()
                .frame(height: 80)
                .foregroundStyle(.primary)
            VStack(alignment: .leading) {
                Text("\(profile.displayName ?? "Unknown")")
                    .font(.title)
                Text("\(profile.email ?? "Unknown")")
                    .font(.headline)
            }
            .foregroundStyle(.primary)
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct UserData_Previews: PreviewProvider {
    static var previews: some View {
        let authViewModel = AuthViewModel()
        authViewModel.signInTestUser()
        authViewModel.updateProfilePicture(url: "https://avatars.githubusercontent.com/u/86660998?v=4")

        return UserData(profile: authViewModel.user!)
    }
}
