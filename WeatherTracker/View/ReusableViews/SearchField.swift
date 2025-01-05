//
//  SearchField.swift
//  WeatherTracker
//
//  Created by Wesley Luntsford on 1/5/25.
//

import SwiftUI

struct SearchField: View {
    @FocusState.Binding var isFocused: Bool
    @Binding var text: String
    let searchAction: () -> Void
    let title: String
    let prompt: String
    
    var body: some View {
        HStack {
            TextField(
                title,
                text: $text,
                prompt: Text(prompt).foregroundStyle(Color.tertiaryText),
                axis: .horizontal
            )
            
            Button {
                searchAction()
                isFocused = false
            } label: {
                Image(.searchIcon)
                    .resizable()
                    .frame(width: 17.5, height: 17.5)
            }
        }
        .keyboardType(.default)
        .poppinsFont(size: 15, weight: .regular)
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled()
        .foregroundStyle(Color.primaryText)
        .padding(.horizontal, 20)
        .padding(.top, 11)
        .padding(.bottom, 12)
        .background(Color.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .circular))
        .focused($isFocused)
        .submitLabel(.search)
        .onTapGesture {
            isFocused = true
        }
        .onSubmit(of: .search) {
            searchAction()
            isFocused = false
        }
    }
}

// MARK: - Preview
#Preview {
    @Previewable @State var text = ""
    @Previewable @FocusState var isFocused: Bool
    
    SearchField(
        isFocused: $isFocused,
        text: $text,
        searchAction: { return },
        title: "Search Field",
        prompt: "Enter a Search"
    )
    .padding()
}
