//
//  DLocationManager.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 10/09/2022.
//

import Foundation
import MapKit

/*
    Helper class used to find the user's current location.
    Once the Location Manager is initialised it triggers an authorisation update
    and requests the user's location. 
 */
class DLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var lastCoordinateRegion = DefaultRegion()
    
    private var locationManager: Optional<CLLocationManager> = CLLocationManager()
    
    override init() {
        super.init()
        
        locationManager?.delegate = self
    }
    
    public func requestLastLocation() -> Void {
        if let locationManager {
            DispatchQueue.main.async {
                locationManager.requestLocation()
            }
        }
    }
    
    private func updateAuthorisationStatus() -> Void {
         if let locationManager {
             switch locationManager.authorizationStatus{
                 
             case .notDetermined:
                 locationManager.requestWhenInUseAuthorization()
                 
             case .restricted:
                 displayLocationServicesDeniedAlert()
                 break
             case .denied:
                 displayLocationServicesDeniedAlert()
                 break
                 
             case .authorizedAlways, .authorizedWhenInUse:
                 locationManager.requestLocation()
                 
             @unknown default:
                 displayLocationServicesDeniedAlert()
                 break
             }
         }
     }
    
    internal func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        updateAuthorisationStatus()
    }
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations.last ?? CLLocation(latitude: 0.0, longitude: 0.0)
    
        lastCoordinateRegion.center.latitude = lastLocation.coordinate.latitude
        lastCoordinateRegion.center.longitude = lastLocation.coordinate.longitude
    }
    
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as NSError? {
            print("Location manager encountered an error: \(error.localizedDescription). The last fetched location is: \"Latitude\(self.lastCoordinateRegion.center.latitude.description) and longitude \(self.lastCoordinateRegion.center.longitude.description)\"")
            }
    }
    
    private func displayLocationServicesDeniedAlert() {
        
        let message = NSLocalizedString("LOCATION_SERVICES_DENIED", comment: "Location services are denied")
        let alertController = UIAlertController(title: NSLocalizedString("LOCATION_SERVICES_ALERT_TITLE", comment: "Location services alert title"),
                                                message: message,
                                                preferredStyle: .alert)
        let settingsButtonTitle = NSLocalizedString("BUTTON_SETTINGS", comment: "Settings alert button")
        let openSettingsAction = UIAlertAction(title: settingsButtonTitle, style: .default) { (_) in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                // Take the user to the Settings app to change permissions.
                UIApplication.shared.open(settingsURL, options: [:]) { _ in
                    print("User redirected to Settings app.")
                }
            }
        }
        
        let cancelButtonTitle = NSLocalizedString("BUTTON_CANCEL", comment: "Location denied cancel button")
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { _ in
            
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(openSettingsAction)
    }
}
