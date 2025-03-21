//
//  PageResume.swift
//  diary_app
//
//  Created by Quentin Banet on 18/03/2025.
//

import SwiftUI

struct PageResume: View {
    var entry: DiaryEntry

    var body: some View {
        HStack {
            Text(entry.date, style: .date)
                .font(.caption)
                .foregroundColor(.gray)
                .frame(width: 100, alignment: .leading)

            Text(entry.feeling.emoji)
                .font(.subheadline)
                .bold()
                .frame(width: 20, height: 20, alignment: .leading)

            Divider()
                .frame(height: 40)
            
            Text(entry.title)
                .font(.headline)
                .frame(maxWidth: .infinity,maxHeight: 30 , alignment: .leading)
        }
        .padding(.horizontal)
        .frame(height: 60)
        .background(content: { Color.gray.opacity(0.1) })
    }
}

#Preview {
    PageResume(entry:
                DiaryEntry(username: "test",
                           date: Date(),
                           title: "Oui oui baguette",
                           feeling: feelings.joy,
                           text: "Je ne sais pas quoi ecrire"
                          )
    )
}
