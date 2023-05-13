//
//  DMapRegion.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 28/12/2022.
//

import Foundation
import MapKit

/*
    The DMapPlacemark object is used to track the area of focus on the map.
    The app gives users the ability to either set their current location
    as the start of the route planning process, or the address of a specific
    point of interest on the map.
 
    A helper class DMapAnnotation is used to store the coordinates of all
    locations that are going to be used as a map annotation. 
 */

struct DMapAnnotation: Identifiable {
    let id = UUID()
    var coordinates = DefaultCoordinates()
}

class DMapPlacemark: ObservableObject {
    
    @Published var region = DefaultRegion()
    @Published var name = "Loading..."
    @Published var annotations = [DMapAnnotation()]

    public func updateMapRegion(newRegion: MKCoordinateRegion) -> Void {
        self.region = newRegion
        self.annotations[0].coordinates = newRegion.center
    }
    
    public func updateMapRegion(newCoordinate: Optional<CLLocationCoordinate2D>) -> Void {
        self.region.center = newCoordinate ?? DefaultCoordinates()
        self.annotations[0].coordinates = newCoordinate ?? DefaultCoordinates()
    }
}
