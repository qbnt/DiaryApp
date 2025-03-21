//
//  SwiftUIView.swift
//  diary_app
//
//  Created by Quentin Banet on 07/03/2025.
//

import SwiftUI

struct NoiseEffect: View {
    var blurSize: CGFloat
    var body: some View {
        Canvas { context, size in
            for _ in 0..<8000 {
                let x = CGFloat.random(in: 0..<size.width)
                let y = CGFloat.random(in: 0..<size.height)
                let opacity = Double.random(in: 0.02...0.08)
                
                context.fill(Path(ellipseIn: CGRect(x: x, y: y, width: blurSize, height: blurSize)),
                             with: .color(.white.opacity(opacity)))
            }
        }
        .ignoresSafeArea()
        .blendMode(.overlay)
        .blur(radius: 4)
    }
}

#Preview {
    NoiseEffect(blurSize: 4)
}
