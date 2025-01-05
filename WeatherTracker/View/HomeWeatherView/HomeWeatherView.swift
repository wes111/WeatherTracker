//
//  ContentView.swift
//  WeatherTracker
//
//  Created by Wesley Luntsford on 1/4/25.
//

import SwiftUI

struct HomeWeatherView: View {
    @State private var viewModel = HomeWeatherViewModel()
    
    var body: some View {
        NavigationStack {
            content
                .searchable(text: $viewModel.searchText, prompt: "Search for a city")
                .onSubmit(of: .search) {
                    viewModel.updateSearchText()
                }
                .onChange(of: viewModel.userInputText, { _, _ in
                    viewModel.updateSearchText()
                })
                .task(id: viewModel.searchText) {
                    guard !viewModel.searchText.isEmpty else {
                        return
                    }
                    await viewModel.search()
                }
                .task {
                    await viewModel.fetchSavedCity()
                }
                .alert("Error Fetching Weather Details", isPresented: $viewModel.showAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text("Please try again Later")
                }
        }
    }
}

// MARK: - Subviews
extension HomeWeatherView {
    var content: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
                
            case .weather(let weather):
                CityWeatherView(viewModel: .init(weather: weather))
                
            case .cities(let cities):
                citiesList(cities)
                
            case .error:
                EmptyView()
                
            case .noCityResults:
                EmptyView()
                
            case .noCitySelected:
                noCitySelectedView
                
            case .citySelected(let city):
                ProgressView()
                    .task {
                        await viewModel.fetchWeatherForCity(id: city.id)
                    }
            }
        }
        .animation(.easeInOut, value: viewModel.state)
    }
    
    var noCitySelectedView: some View {
        VStack(spacing: 10) {
            Text("No City Selected")
                .poppinsFont(size: 30, weight: .semibold)
            
            Text("Please Search For A City")
                .poppinsFont(size: 15, weight: .semibold)
        }
        .foregroundStyle(Color.primaryText)
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.top, 240)
        
    }
    
    func citiesList(_ cities: [City]) -> some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(cities) { city in
                    Button {
                        viewModel.onSelectCity(city)
                    } label: {
                        WeatherCard(viewModel: .init(city: city))
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
    }
}

// MARK: - Preview
#Preview {
    HomeWeatherView()
}