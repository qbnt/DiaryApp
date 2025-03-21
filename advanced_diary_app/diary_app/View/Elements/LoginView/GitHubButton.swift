//
//  GitHubButton.swift
//  diary_app
//
//  Created by Quentin Banet on 07/03/2025.
//

import SwiftUI
import FirebaseAuth

struct GitHubButton: View {
    @EnvironmentObject var authManager: AuthViewModel
    
    var body: some View {
        Button(action: {
            Task {
                await authManager.signInWithGitHub()
            }
        }) {
            HStack {
                Image("logoGitHub")
                    .resizable()
                    .frame(width: 35, height: 35)
                Text("Connexion GitHub")
                    .font(.callout)
                    .foregroundStyle(.blue)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(10)
            .frame(width: 250, height: 50)
            .background(Color.white)
            .clipShape(Capsule())
        }
    }
}

#Preview {
    GitHubButton()
        .background(Color.gray)
}
