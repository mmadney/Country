//
//  CustomFont.swift
//  Event
//
//  Created by Madney on 27/03/2024.
//

import SwiftUI

struct CustomFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory

    let color: Color
    private var size: CGFloat
    private var weight: Font.Weight

    public enum TextStyle {
        case title1
        case title2
        case subTitle
        case label0
        case label1
    }

    init(textStyle: TextStyle, color: Color = ThemeColor.black) {
        switch textStyle {
        case .title1:
            self.init(size: 18, weight: .heavy, color: color)
        case .title2:
            self.init(size: 37, weight: .heavy, color: color)
        case .subTitle:
            self.init(size: 16, weight: .medium, color: color)
        case .label0:
            self.init(size: 14, weight: .semibold, color: color)
        case .label1:
            self.init(size: 14, weight: .medium, color: color)
        }
    }

    init(size: CGFloat, weight: Font.Weight, color: Color) {
        self.size = size
        self.weight = weight
        self.color = color
    }

    func body(content: Content) -> some View {
        return content
            .font(scaledFont)
            .fontWeight(weight)
            .foregroundColor(color)
    }

    var scaledFont: Font {
        let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return Font.custom(fontName, size: scaledSize)
    }

    private var fontName: String {
        return "Avenir"
    }
}

extension View {
    func customFont(_ textStyle: CustomFont.TextStyle) -> some View {
        modifier(CustomFont(textStyle: textStyle))
    }

    func customFont(_ textStyle: CustomFont.TextStyle, _ color: Color) -> some View {
        modifier(CustomFont(textStyle: textStyle, color: color))
    }

    func customFont(size: CGFloat, weight: Font.Weight, color: Color) -> some View {
        modifier(CustomFont(size: size, weight: weight, color: color))
    }
}

