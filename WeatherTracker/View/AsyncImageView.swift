//
//  fff.swift
//  WeatherTracker
//
//  Created by Wesley Luntsford on 1/4/25.
//

import SwiftUI

struct AsyncImageView: View {
    let imageURL: URL?
    
    var body: some View {
        if let imageURL = imageURL {
            AsyncImage(
                url: imageURL,
                content: { image in
                    image
                        .resizable()
                        .scaledToFit()
                },
                placeholder: {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
            )
        } else {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.gray)
        }
    }
}
