//
//  DMapRegion.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 28/12/2022.
//

import Foundation
import MapKit
import SwiftUI

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
    
    @Published var name = "Loading..."
    @Published var region = DefaultRegion()
    @Published var annotations = [DMapAnnotation()]
    
    public func updateMapRegion(newMapPlacemark: DMapPlacemark) -> Void {
        withAnimation{
            self.name = newMapPlacemark.name
            self.region = newMapPlacemark.region
            self.annotations[0].coordinates = newMapPlacemark.region.center
        }
    }

    public func updateMapRegion(newRegion: MKCoordinateRegion, newRegionName: String) -> Void {
        self.region = newRegion
        self.annotations[0].coordinates = newRegion.center
        self.name = newRegionName
    }
    
    public func updateMapRegion(newRegion: Optional<MKPlacemark>) -> Void {
        self.region.center = newRegion?.coordinate ?? DefaultCoordinates()
        self.annotations[0].coordinates = newRegion?.coordinate ?? DefaultCoordinates()
        self.name = newRegion?.name ?? "Loading..."
    }
}
