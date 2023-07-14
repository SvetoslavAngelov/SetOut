//
//  SetOutApp.swift
//  SetOut
//
//  Created by Svetoslav Angelov on 12/05/2023.
//

import SwiftUI

@main
struct SetOutApp: App {
    
    // Custom navigation stack, used to switch between the
    // three main sub views in the app:
    // 1. Search view - set a start location of the route
    // 2. Options view - specify route options
    // 3. Itinerary view - the generated route
    @StateObject var navigationStack = DNavigationStack()
    
    // Object which handles all requests to the server
    // and stores responses.
    @StateObject var httpRequest = DHttpRequest()
    
    // Manages the user location and updates the map region
    // based on the search location.
    @StateObject var locationService = DLocationService()
    
    // Handles the search for specific address or location
    // using Apple Maps search API.
    @StateObject var locationSearch = DLocationSearch()
    
    var body: some Scene {
        WindowGroup {
            VMainView()
                .environmentObject(navigationStack)
                .environmentObject(httpRequest)
                .environmentObject(locationService)
                .environmentObject(locationSearch)
        }
    }
}
