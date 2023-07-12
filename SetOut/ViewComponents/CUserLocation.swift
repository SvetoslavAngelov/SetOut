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
    @EnvironmentObject var locationService: DLocationService
    
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
        locationService.requestLastLocation()
    }
    
    private func navigateToOptions() -> Void {
        navigationStack.navigateTo(.optionsView)
    }
}

struct CUserLocation_Previews: PreviewProvider {
    static var previews: some View {
        CUserLocation()
            .environmentObject(DNavigationStack())
            .environmentObject(DLocationService())
    }
}
