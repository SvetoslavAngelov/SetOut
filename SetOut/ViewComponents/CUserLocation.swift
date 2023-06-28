//
//  CUserLocation.swift
//  SetOut
//
//  Created by Svetoslav Angelov on 02/01/2023.
//

import SwiftUI

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
        let lastUserLocation = locationManager.lastCoordinateRegion
        locationManager.requestLastLocation()
        
        if lastUserLocation == locationManager.lastCoordinateRegion{
            
            // move the map view back to the user's original location.
            mapPlacemark.updateMapRegion(newRegion: locationManager.lastCoordinateRegion, newRegionName: "Current Location")
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
