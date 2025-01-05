//
//  Font+Extensions.swift
//  WeatherTracker
//
//  Created by Wesley Luntsford on 1/4/25.
//

import SwiftUI

extension View {
    func poppinsFont(size: CGFloat, weight: Font.Weight = .regular) -> some View {
        modifier(PoppinsFontModifier(size: size, weight: weight))
    }
}

fileprivate struct PoppinsFontModifier: ViewModifier {
    let size: CGFloat
    let weight: Font.Weight

    func body(content: Content) -> some View {
        let fontName: String
        switch weight {
        case .bold:
            fontName = "Poppins-Bold"
        case .medium:
            fontName = "Poppins-Medium"
        case .semibold:
            fontName = "Poppins-SemiBold"
        case .light:
            fontName = "Poppins-Light"
        default:
            fontName = "Poppins-Regular"
        }

        return content
            .font(.custom(fontName, size: size))
    }
}
