//
//  ButtumBar.swift
//  diary_app
//
//  Created by Quentin Banet on 10/03/2025.
//

import SwiftUI

struct BottomBar: View {
    @Binding var selectedMenu: MenuOption
    @EnvironmentObject var authManager: AuthViewModel
    var body: some View {
        HStack {
            if !authManager.isLoggedIn {
                LoginButton()
            } else {
                HStack {
                    Spacer()
                    Button(action: {
                        selectedMenu = MenuOption.home
                    }) {
                        ZStack {
                            Image(systemName: selectedMenu == MenuOption.home ? "book.circle" :"book.closed.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .scaledToFit()
                                .foregroundStyle(selectedMenu == MenuOption.home ? .blue : .white)
                        }
                    }
                    Spacer()
                    Button(action: {
                        selectedMenu = MenuOption.calendar
                    }) {
                        Image(systemName: "calendar.circle")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .scaledToFit()
                            .foregroundStyle(selectedMenu == MenuOption.calendar ? .blue : .white)
                    }
                    Spacer()
                }
                .frame(maxWidth: 200, minHeight: 55)
                .background(Color.gray.opacity(0.4))
                .clipShape(Capsule())
                .foregroundColor(.white)
                .padding(.bottom)
            }
        }
    }
}
