//
//  PopupPageInput.swift
//  diary_app
//
//  Created by Quentin Banet on 17/03/2025.
//

import SwiftUI

struct FormInputType {
    var title: String
    var content: String
    var mood: feelings
}

struct PopupPageInput: View {
    @EnvironmentObject var diary: Diary
    @EnvironmentObject var authManager: AuthViewModel
    @Binding var showSheet: Bool
    
    @State private var formInput = FormInputType(title: "", content: "", mood: .joy)
    
    var body: some View {
        ZStack {
            Background()
            
            VStack {
                Text("What would you like to say?")
                    .font(.title2)
                    .padding(.top, 50)
                    .foregroundStyle(.white)
                
                ScrollView(.vertical, showsIndicators: false) {
                    FormPageInput(input: $formInput)
                }
                
                Button(action: {
                    diary.addEntry(DiaryEntry(
                        username: authManager.user?.email ?? "unknown",
                        date: Date(),
                        title: formInput.title,
                        feeling: formInput.mood,
                        text: formInput.content
                    ))
                    showSheet.toggle()
                }) {
                    Text("Add")
                        .frame(width: 150, height: 50)
                }
                .shadow(radius: 10)
                .background(.gray.opacity(0.4))
                .cornerRadius(30)
            }
        }
    }
}

struct PopupPageInput_Previews: PreviewProvider {
    static var previews: some View {
        @State var previewValue: Bool = true
        let authViewModel = AuthViewModel()
        authViewModel.signInTestUser()
        authViewModel.updateProfilePicture(url: "https://avatars.githubusercontent.com/u/86660998?v=4")

        return PopupPageInput(showSheet: $previewValue)
            .environmentObject(Diary())
            .environmentObject(authViewModel)
    }
}
