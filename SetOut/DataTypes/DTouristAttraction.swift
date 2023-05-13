//
//  DTouristAttraction.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 10/09/2022.
//

import Foundation
import CoreLocation
import SwiftUI

struct Coordinates: Hashable, Codable {
    var latitude: Double
    var longitude: Double
}

struct DTouristAttraction: Identifiable, Hashable, Codable {
    
    // Public interface
    var id: Int
    
    var name: String
    var city: String
    var country: String
    var description: String
    
    var isOpen: Bool
    
    var rating: Double
    
    var distance: Double
    var unitDistance: String
    
    var isFavourite: Bool
    
    
    // Private interface
    
    // Image of the tourist attraction
    private var attractionImageName: String
    var attractionImage: Image {
        Image(attractionImageName)
    }
    
    // The tourist attraction location coordinates
    var coordinates: Coordinates
    var mapKitCoordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude
        )
    }
    
}
