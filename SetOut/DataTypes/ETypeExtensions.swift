//
//  ETypeExtensions.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 10/09/2022.
//

import Foundation
import MapKit

extension CGSize: Comparable {
    public static func < (lhs: CGSize, rhs: CGSize) -> Bool {
        return lhs.height < rhs.height
    }
    
    public static func > (lhs: CGSize, rhs: CGSize) -> Bool {
        return lhs.height > rhs.height
    }
    
    public static func == (lhs: CGSize, rhs: CGSize) -> Bool {
        return lhs.width == rhs.width && lhs.height == rhs.height
    }
    
    public static func != (lhs: CGSize, rhs: CGSize) -> Bool {
        return !(lhs == rhs)
    }
    
    public static  func + (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
}

extension MKCoordinateRegion: Equatable {
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        return lhs.center.longitude == rhs.center.longitude &&
        lhs.center.latitude == rhs.center.latitude
    }
    
    public static func != (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        return !(lhs == rhs)
    }
}

