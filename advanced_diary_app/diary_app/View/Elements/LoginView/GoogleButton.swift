//
//  GoogleButton.swift
//  diary_app
//
//  Created by Quentin Banet on 07/03/2025.
//

import SwiftUI

struct GoogleButton: View {
    @EnvironmentObject var authManager: AuthViewModel
    var body: some View {
        Button(action: {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootViewController = windowScene.windows.first?.rootViewController {
                authManager.signInWithGoogle(presentingViewController: rootViewController)
            }
        }) {
            HStack {
                Image("logoGoogle")
                    .resizable()
                    .frame(width: 35, height: 35)
                Text("Connexion Google")
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
    GoogleButton()
        .background(Color.gray)
}
