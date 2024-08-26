//
//  View.swift
//  MovieappMV
//
//  Created by Guillaume Afanou on 21/08/2024.
//

import SwiftUI

/// A view modifier that adds rounded corners and a stroked border to the view.
struct RoundedStrokedView: ViewModifier {
    let cornerRadius: CGFloat
    let strokeColor: Color
    let lineWidth: CGFloat

    /// Modifies the content view by adding rounded corners and a stroked border.
    ///
    /// - Parameter content: The content view to modify.
    /// - Returns: A modified view with rounded corners and a stroked border.
    func body(content: Content) -> some View {
        content
            .clipShape(.rect(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(strokeColor, lineWidth: lineWidth)
            )
    }
}

struct RectKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

public extension View {
    /// Adds rounded corners and a stroked border to the view.
    ///
    /// - Parameters:
    ///   - cornerRadius: The radius to use when drawing rounded corners for the view.
    ///   - strokeColor: The color of the stroke border.
    ///   - lineWidth: The width of the stroke border.
    /// - Returns: A modified view with rounded corners and a stroked border.
    func roundedStrokedView(cornerRadius: CGFloat, strokeColor: Color, lineWidth: CGFloat) -> some View {
        modifier(RoundedStrokedView(cornerRadius: cornerRadius, strokeColor: strokeColor, lineWidth: lineWidth))
    }
    
    @ViewBuilder
    func rect(completion: @escaping (CGRect) -> ()) -> some View {
        self.overlay {
            GeometryReader {
                let rect = $0.frame(in: .scrollView(axis: .horizontal))
                
                Color.clear.preference(key: RectKey.self, value: rect)
                    .onPreferenceChange(RectKey.self, perform: completion)
            }
        }
    }
}
