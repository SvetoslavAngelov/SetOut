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
    @EnvironmentObject var httpRequest: DHttpRequest
    @State var mapPlacemark = DMapPlacemark()
    
    var body: some View {
        Map(coordinateRegion: $mapPlacemark.region, showsUserLocation: true, annotationItems: mapPlacemark.annotations) {
            MapMarker(coordinate: $0.coordinates, tint: .blue)
        }
            .ignoresSafeArea()
            .onChange(of: locationService.isLocationUpdated) {_ in
                withAnimation{
                    self.mapPlacemark.region = locationService.getMapPlacemark().region
                    self.mapPlacemark.annotations = locationService.getMapPlacemark().annotations
                }
            }
            .onChange(of: locationService.isLocationUpdated) {_ in
                drawRoute()
            }
    }
    
    private func drawRoute(){
        
        //let places = httpRequest.serverResult
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 51.505507, longitude: -0.075402), addressDictionary: nil))
        
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 51.502937, longitude: 0.003182), addressDictionary: nil))
        request.transportType = .automobile
        request.requestsAlternateRoutes = true
        
        let directions = MKDirections(request: request)
        directions.calculate { (response, error) in
            if let error = error {
                print("Error calculating directions: \(error)")
                return
            }
            
            if let route = response?.routes.first {
                let mapRect = route.polyline.boundingMapRect
                self.mapPlacemark.region = MKCoordinateRegion(mapRect)
                print("calculated route")
            }
        }
    }
}

struct CMapView_Previews: PreviewProvider {
    static var previews: some View {
        CMapView()
            .environmentObject(DLocationService())
            .environmentObject(DHttpRequest())
    }
}
