//
//  LoginButton.swift
//  diary_app
//
//  Created by Quentin Banet on 07/03/2025.
//

import SwiftUI

struct LoginButton: View {
    var body: some View {
        NavigationLink(destination: LoginView()) {
            Text("Login")
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
    LoginButton()
}
