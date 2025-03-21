//
//  CalendarView.swift
//  diary_app
//
//  Created by Quentin Banet on 17/03/2025.
//

import SwiftUI

struct CalendarView: View {
    @State var selectedDate: Date = Date()
    
    var body: some View {
        VStack {
            DatePicker("Selectionner une date", selection: $selectedDate, displayedComponents: [.date])
                .datePickerStyle(.graphical)
            Divider()
            ListSelectedDate(selectedDate: $selectedDate)
        }
    }
}

#Preview {
    CalendarView()
        .environmentObject(Diary.preview)
}
