//
//  DismissKeyboardOnDragModifier.swift
//  WeatherTracker
//
//  Created by Wesley Luntsford on 1/5/25.
//

import SwiftUI

extension View {
    func dismissKeyboardOnDrag() -> some View {
        self.modifier(DismissKeyboardOnDragModifier())
    }
}

fileprivate struct DismissKeyboardOnDragModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .contentShape(Rectangle())
            .gesture(DragGesture().onChanged { _ in
                UIApplication.shared.sendAction(
                    #selector(UIResponder.resignFirstResponder),
                    to: nil,
                    from: nil,
                    for: nil
                )
            })
    }
}


