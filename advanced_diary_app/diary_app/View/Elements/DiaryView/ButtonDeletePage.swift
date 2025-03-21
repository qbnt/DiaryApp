//
//  ButtonDeletePage.swift
//  diary_app
//
//  Created by Quentin Banet on 18/03/2025.
//

import SwiftUI

struct ButtonDeletePage: View {
    @EnvironmentObject var diary: Diary
    
    var pageId: UUID
    private var page: DiaryEntry? {
        diary.entries.first { $0.id == pageId }
    }
    
    @Binding var showSheet: Bool
    
    @State private var alertText: String = ""
    @State private var isPresented: Bool = false
    
    var body: some View {
        Button(action: {
            alertText = "Are you sure you want to delete this diary page?"
            isPresented.toggle()
        }) {
            ZStack {
                Rectangle()
                    .frame(width: 100, height: 50)
                    .foregroundStyle(.gray.opacity(0.4))
                    .cornerRadius(30)
                Text("Delete")
                    .foregroundStyle(.red)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .alert(isPresented: $isPresented) {
            Alert(
                title: Text("Diary"),
                message: Text(alertText),
                primaryButton: .destructive(Text("Yes")
                    .bold()
                ) {
                    showSheet.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        diary.deleteEntry(page!)
                    }
                },
                secondaryButton: .cancel(Text("Cancel")
                    .foregroundColor(.blue)
                )
            )
        }
    }
}

