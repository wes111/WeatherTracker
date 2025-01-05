//
//  CityWeatherView.swift
//  WeatherTracker
//
//  Created by Wesley Luntsford on 1/4/25.
//

import SwiftUI

struct CityWeatherView: View {
    @ScaledMetric(relativeTo: .title3) var locationImageSize = 21.0
    let viewModel: CityWeatherViewModel
    
    var body: some View {
        VStack(spacing: 35) {
            overviewStack
            detailsCard
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.top, 80)
    }
}

// MARK: - Subviews
extension CityWeatherView {
    var overviewStack: some View {
        VStack(spacing: 0) {
            AsyncImageView(imageURL: viewModel.weather.conditionImageName)
                .frame(maxHeight: 133)
            
            HStack(alignment: .center, spacing: 11) {
                Text(viewModel.cityName)
                    .poppinsFont(size: 30, weight: .semibold)
                    .foregroundStyle(Color.primaryText)
                
                Image(.location)
                    .frame(width: locationImageSize, height: locationImageSize)
            }
            .padding(.bottom, 24)
            
            Text(viewModel.temperatureText)
                .poppinsFont(size: 70, weight: .medium)
                .foregroundStyle(Color.primaryText)
        }
    }
    
    var detailsCard: some View {
        HStack(spacing: 56) {
            detail(title: "Humidity", value: viewModel.humidityText)
            detail(title: "UV", value: viewModel.uvIndexText)
            detail(title: "Feels Like", value: viewModel.feelsLikeText)
        }
        .padding([.vertical, .leading], 16)
        .padding(.trailing, 28)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.secondaryBackground)
        )
    }
    
    func detail(title: String, value: String) -> some View {
        VStack(spacing: 2) {
            Text(title)
                .poppinsFont(size: 12, weight: .medium)
                .foregroundStyle(Color.tertiaryText)
            
            Text(value)
                .poppinsFont(size: 15, weight: .medium)
                .foregroundStyle(Color.secondaryText)
        }
    }
}

// MARK: - Preview
#Preview {
    CityWeatherView(viewModel: .init(weather: .preview))
        .padding()
}
