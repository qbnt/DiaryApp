//
//  loginView.swift
//  diary_app
//
//  Created by Quentin Banet on 07/03/2025.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authManager: AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Background()
            VStack {
                Spacer()
                VStack {
                    Image(systemName: "point.3.connected.trianglepath.dotted")
                        .resizable()
                        .frame(width: 90, height: 80)
                    Text("Welcome")
                        .font(.largeTitle)
                }
                Spacer()
                Spacer()
                VStack(spacing: 15) {
                    if !authManager.isLoggedIn {
                        GoogleButton()
                        GitHubButton()
                    } else {
                        Text("You're alrady logged in!")
                            .onAppear {
                                presentationMode.wrappedValue.dismiss()
                            }
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    LoginView()
}
