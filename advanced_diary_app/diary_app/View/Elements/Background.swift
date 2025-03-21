//
//  Background.swift
//  diary_app
//
//  Created by Quentin Banet on 07/03/2025.
//

import SwiftUI

struct Background: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.green.opacity(0.7), .gray.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottom)
            .ignoresSafeArea()
            NoiseEffect(blurSize: 4)
        }
    }
}

#Preview {
    Background()
}
