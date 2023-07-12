//
//  DLocationService.swift
//  SetOut
//
//  Created by Svetoslav Angelov on 10/07/2023.
//

import Foundation
import MapKit

// An abstraction that exposes a read only interface to clients.
// It includes both a DLocationManager class which manages user location,
// and a DLocationSearch class which handles search completion and initiates
// map search with fully formed address strings.

class DLocationService: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var isLocationUpdated = false
    
    private var locationManager: Optional<CLLocationManager> = CLLocationManager()
    private var mapPlacemark = DMapPlacemark()
    
    private var isInUseLocationAuthorised = false
    
    override init() {
        super.init()
        
        locationManager?.delegate = self
    }
    
    private func updateAuthorisationStatus() -> Void {
         if let locationManager {
             switch locationManager.authorizationStatus{
                 
             case .notDetermined:
                 locationManager.requestWhenInUseAuthorization()
             case .restricted:
                 // Redirect to settings
                 print("Location use restricted")
                 break
             case .denied:
                 // Redirect to settings
                 print("Location use denied")
                 break
             case .authorizedAlways, .authorizedWhenInUse:
                 self.isInUseLocationAuthorised = true
             @unknown default:
                 print("Location services encountered an unknown error.")
                 break
             }
         }
     }
    
    // Request location & update placemark
    public func requestLastLocation() -> Void {
        if let locationManager {
            if self.isInUseLocationAuthorised {
                DispatchQueue.main.async {
                    locationManager.requestLocation()
                }
            }
        }
    }
    
    // Get the last Map Placemark
    public func getMapPlacemark() -> DMapPlacemark {
        return self.mapPlacemark
    }
    
    // Update the last Map Placemark
    public func setMapPlacemark(newPlacemark: Optional<MKPlacemark>) -> Void {
        self.mapPlacemark.updateMapRegion(newRegion: newPlacemark)
        self.isLocationUpdated.toggle()
    }

    /*
        Class delegate interface
     */
    internal func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        updateAuthorisationStatus()
    }
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newRegion = MKCoordinateRegion(center: locations.last?.coordinate ?? DefaultCoordinates(), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        
        self.mapPlacemark.updateMapRegion(newRegion: newRegion, newRegionName: "Current Location")
        self.isLocationUpdated.toggle()
        print("Location updated")
    }
    
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as NSError? {
            print("Location manager encountered an error: \(error.localizedDescription). The last fetched location is: \"Latitude\(self.mapPlacemark.region.center.latitude.description) and longitude \(self.mapPlacemark.region.center.longitude.description)\"")
            }
    }
    
}
