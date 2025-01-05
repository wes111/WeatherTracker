//
//  WeatherCard.swift
//  WeatherTracker
//
//  Created by Wesley Luntsford on 1/4/25.
//

import SwiftUI

struct WeatherCard: View {
    @State private var viewModel: WeatherCardViewModel
    
    init(viewModel: WeatherCardViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content
            .task {
                await viewModel.fetchWeather()
            }
    }
}

// MARK: - Subviews
private extension WeatherCard {
    var content: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(viewModel.city.name)
                    .poppinsFont(size: 20, weight: .semibold)
                
                Text(viewModel.temperatureText)
                    .poppinsFont(size: 60, weight: .medium)
            }
            .foregroundStyle(Color.primaryText)
            .padding(.vertical, 16)
            
            Spacer()
            
            AsyncImageView(imageURL: viewModel.weather?.conditionImageName)
                .frame(maxHeight: 100)
        }
        .padding(.horizontal, 31)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.secondaryBackground)
        )
    }
}

// MARK: - Preview
#Preview {
    WeatherCard(viewModel: .preview)
        .frame(height: 117)
        .padding()
}
