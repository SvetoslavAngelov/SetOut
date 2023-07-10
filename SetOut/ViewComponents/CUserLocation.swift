//
//  CUserLocation.swift
//  SetOut
//
//  Created by Svetoslav Angelov on 02/01/2023.
//

import SwiftUI

/*
    The CUserLocation view component is used to request the user's
    location via a DLocationManager object.
 */

struct CUserLocation: View {
    
    @EnvironmentObject var navigationStack: DNavigationStack
    @EnvironmentObject var locationManager: DLocationManager
    @EnvironmentObject var mapPlacemark: DMapPlacemark
    
    var body: some View {
        Button{
            requestLocation()
            navigateToOptions()
        } label: {
            Text("\(Image(systemName: "location"))")
                .font(.title2)
        }
    }
    
    private func requestLocation() -> Void {
        // Check user location authorisation status
        // Request location
        // Update map placemark
        // Toggle map placemark did change 
        
        let lastUserLocation = locationManager.lastCoordinateRegion
        locationManager.requestLastLocation()
        
        if lastUserLocation == locationManager.lastCoordinateRegion{
            
            // If the user's location hasn't changed since the last request,
            // move the map view centre back to it. 
            mapPlacemark.updateMapRegion(newRegion: lastUserLocation, newRegionName: "Current Location")
        }
    }
    
    private func navigateToOptions() -> Void {
        navigationStack.navigateTo(.optionsView)
    }
}

struct CUserLocation_Previews: PreviewProvider {
    static var previews: some View {
        CUserLocation()
            .environmentObject(DNavigationStack())
            .environmentObject(DLocationManager())
            .environmentObject(DMapPlacemark())
    }
}
