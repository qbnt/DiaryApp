//
//  TopBar.swift
//  diary_app
//
//  Created by Quentin Banet on 07/03/2025.
//

import SwiftUI
import Kingfisher

struct TopBar: View {
    @EnvironmentObject var authManager: AuthViewModel
    @State private var isProfileMenuVisible = false
    
    var body: some View {
        HStack {
            Text("Diary")
                .font(.largeTitle)
                .bold()
            
            Spacer()
            
            if let profile = authManager.user {
                Button(action: {
                    isProfileMenuVisible.toggle()
                }) {
                    KFImage(profile.photoURL)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 3))
                }
                .popover(isPresented: $isProfileMenuVisible, arrowEdge: .top) {
                    ProfileMenue(profile: profile)
                        .ignoresSafeArea()
                }
            } else {
                NavigationLink(destination: LoginView()) {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
            }
        }
        .foregroundStyle(.white)
        .padding()
        .background(Color.gray.opacity(0.2))
        .clipShape(Capsule())
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}

#Preview {
    TopBar()
}
