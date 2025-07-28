//
//  ExampleApp.swift
//  Example
//
//  Created by Hiral Naik on 7/25/25.
//

import SwiftUI
import ios_api_service

@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            let service = RequesterService()
            let apiService = APIService(networkService: service)
            let viewModel = UserViewModel(service: apiService)
            ContentView(viewModel: viewModel)
        }
    }
}
