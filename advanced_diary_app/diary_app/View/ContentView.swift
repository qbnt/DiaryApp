//
//  ContentView.swift
//  diary_app
//
//  Created by Quentin Banet on 07/03/2025.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

struct ContentView: View {
    @State private var selectedMenu = MenuOption.home
    
    var body: some View {
        NavigationStack {
            ZStack {
                Background()
                VStack {
                    TopBar()
                    Spacer()
                    MainView(selectedMenu: $selectedMenu)
                    Spacer()
                    BottomBar(selectedMenu: $selectedMenu)
                }
            }
        }
    }
}

// ------------- Preview ------------- //
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            previewWithTestUser()
            previewWithoutUser()
        }
    }

    static func previewWithTestUser() -> some View {
        let authViewModel = AuthViewModel()
        authViewModel.signInTestUser()
        authViewModel.updateProfilePicture(url: "https://avatars.githubusercontent.com/u/86660998?v=4")
        return ContentView()
            .environmentObject(authViewModel)
            .environmentObject(Diary.preview)
            .previewDisplayName("Avec utilisateur")
    }

    static func previewWithoutUser() -> some View {
        ContentView()
            .environmentObject(AuthViewModel())
            .environmentObject(Diary.preview)
            .previewDisplayName("Sans utilisateur")
    }
}
