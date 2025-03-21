//
//  LogoutButton.swift
//  diary_app
//
//  Created by Quentin Banet on 10/03/2025.
//

import SwiftUI

struct LogoutButton: View {
    @EnvironmentObject var authManager: AuthViewModel
    var body: some View {
        Button(action: {
            authManager.signOut()
        }) {
            Text("Logout")
                .frame(maxWidth: .infinity, minHeight: 50)
                .frame(maxWidth: 150)
                .background(Color.gray.opacity(0.6))
                .clipShape(Capsule())
                .foregroundColor(.white)
                .padding(.bottom)
        }
    }
}

#Preview {
    LogoutButton()
}
