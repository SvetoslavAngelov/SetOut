//
//  ETypeDefaults.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 28/12/2022.
//

import Foundation
import MapKit

func abs(_ a: CGSize) -> CGSize {
    return CGSize(width: abs(a.width), height: abs(a.height))
}

func DefaultRegion() -> MKCoordinateRegion {
    return MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.476833, longitude: -0.000536),
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
}

func DefaultCoordinates() -> CLLocationCoordinate2D {
    return CLLocationCoordinate2D(latitude: 51.476833, longitude: -0.000536)
}
