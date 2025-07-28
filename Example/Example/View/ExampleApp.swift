//
//  ExampleApp.swift
//  Example
//
//  Created by Hiral Naik on 7/25/25.
//

import SwiftUI
import SwiftServiceKit

@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            let service = RequesterService()
            let apiService = SwiftServiceKit.RequesterAPIService(networkService: service)
            let clientService = APIService(apiService: apiService)
            let viewModel = UserViewModel(service: clientService)
            ContentView(viewModel: viewModel)
        }
    }
}
