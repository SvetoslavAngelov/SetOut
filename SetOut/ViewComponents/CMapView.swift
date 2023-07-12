//
//  CMapView.swift
//  SetOut
//
//  Created by Svetoslav Angelov on 06/12/2022.
//

import SwiftUI
import MapKit

/*
    A simple Map view, which centres on the mapRegion environment
    variable. The mapRevion variable can be set by the user to either
    their current location, or other point of interest on the map.
 */

struct CMapView: View {
    
    @EnvironmentObject var locationService: DLocationService
    @State var mapPlacemark = DMapPlacemark()
    
    var body: some View {
        Map(coordinateRegion: $mapPlacemark.region, showsUserLocation: true, annotationItems: mapPlacemark.annotations) {
            MapMarker(coordinate: $0.coordinates, tint: .blue)
        }
            .ignoresSafeArea()
            .onChange(of: locationService.isLocationUpdated) {_ in
                updateMapPlacemark()
            }
    }
    
    internal func updateMapPlacemark() -> Void {
        withAnimation(.easeInOut(duration: 4.0)){
            self.mapPlacemark.updateMapRegion(newMapPlacemark: locationService.getMapPlacemark())
        }
    }
}

struct CMapView_Previews: PreviewProvider {
    static var previews: some View {
        CMapView()
            .environmentObject(DLocationService())
    }
}
