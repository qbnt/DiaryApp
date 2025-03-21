//
//  FormPageInput.swift
//  diary_app
//
//  Created by Quentin Banet on 18/03/2025.
//

import SwiftUI

struct FormPageInput: View {
    @Binding var input: FormInputType
    
    var body: some View {
        VStack(spacing: 30) {
            TextField(text: $input.title){
                Text("Title")
            }
            .padding(12)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(30)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .shadow(radius: 5)
            .padding()
            
            HStack {
                Text("Mood of the day: ")
                    .foregroundStyle(.white)
                    .bold()
                Picker("Mood of the day", selection: $input.mood) {
                    ForEach(feelings.allCases) { feel in
                        Text("\(feel.rawValue) \(feel.emoji)")
                            .tag(feel)
                            .foregroundStyle(.white)
                    }
                }
                .pickerStyle(DefaultPickerStyle())
            }
            
            ZStack(alignment: .topLeading) {
                if input.content.isEmpty {
                    Text("Write something here...")
                        .foregroundColor(.gray)
                        .padding(20)
                        .padding(.horizontal)
                }
                
                TextEditor(text: $input.content)
                    .frame(minHeight: 150, alignment: .top)
                    .padding(12)
                    .scrollContentBackground(.hidden)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .shadow(radius: 5)
                    .padding(.horizontal)
            }
        }
    }
}

extension DateFormatter {
    static var shortDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
}

#Preview {
    ZStack {
        Background()
        FormPageInput(input: .constant(FormInputType(
            title: "",
            content: "",
            mood: feelings.joy
        )))
    }
}
