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
    
    @EnvironmentObject var mapPlacemark: DMapPlacemark
    @EnvironmentObject var locationManager: DLocationManager
    @EnvironmentObject var locationSearch: DLocationSearch
    
    @State var region = DefaultRegion()
    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: mapPlacemark.annotations) {
            MapMarker(coordinate: $0.coordinates, tint: .blue)
        }
            .ignoresSafeArea()
            .onChange(of: mapPlacemark.region) {_ in
                withAnimation(.easeInOut(duration: 4.0)){
                    region = mapPlacemark.region
                }
            }.onChange(of: locationManager.lastCoordinateRegion) {_ in
                withAnimation(.easeInOut(duration: 4.0)){
                    mapPlacemark.updateMapRegion(newRegion: locationManager.lastCoordinateRegion, newRegionName: "Current Location")
                }
            }.onChange(of: locationSearch.mapPlacemark) {_ in
                withAnimation(.easeInOut(duration: 4.0)){
                    mapPlacemark.updateMapRegion(newRegion: locationSearch.mapPlacemark)
                }
            }
    }
}

struct CMapView_Previews: PreviewProvider {
    static var previews: some View {
        CMapView()
            .environmentObject(DMapPlacemark())
            .environmentObject(DLocationManager())
            .environmentObject(DLocationSearch())
    }
}
