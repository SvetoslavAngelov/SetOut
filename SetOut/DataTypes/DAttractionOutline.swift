//
//  DAttractionOutline.swift
//  SetOut
//
//  Created by Svetoslav Angelov on 17/05/2023.
//

import Foundation
import SwiftUI
import CoreLocation

struct DAttractionOutline: Identifiable, Hashable, Codable {

    var id: Int64
    
    var name: String
    var isOpen: Bool
    var distance: Double
    var rating: Double
    
    var latitude: Double
    var longitude: Double
    
    // Image of the tourist attraction
    private var attractionImageName: String
    var attractionImage: Image {
        Image(attractionImageName)
    }
    
    var mapKitCoordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )
    }
    
    // Default object initialisation
    init(){
        self.id = 0
        self.name = "Loading..."
        self.isOpen = false
        self.distance = 0.0
        self.rating = 0.0
        
        self.latitude = 0.0
        self.longitude = 0.0
        
        attractionImageName = "default"
    }
}
