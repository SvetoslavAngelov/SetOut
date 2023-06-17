//
//  DLocationSearch.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 06/11/2022.
//

import Foundation
import SwiftUI
import MapKit
import Combine

/*
    Helper class which returns address location results based on partial search querries.
    Upon a successful search query, the searchCompletion property returns a list of
    strings which can then be used to perform a map search using Apple's MapKit API.
 */
class DLocationSearch: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    
    @Published var searchCompletion: [MKLocalSearchCompletion] = []
    @Published var mapPlacemark: Optional<MKPlacemark> = nil
    @Published var searchQuery = ""
    
    private var searchCompleter = MKLocalSearchCompleter()
    private var cancellable: AnyCancellable?
    
    // Constrain the search completion to a specific region
    init(_ region: MKCoordinateRegion = DefaultRegion()) {
        super.init()
        
        searchCompleter.delegate = self
        searchCompleter.resultTypes = .pointOfInterest
        searchCompleter.region = region
        
        // Assign the search query to the MKLocalSearchCompleter
        cancellable = $searchQuery.assign(to: \.queryFragment, on: self.searchCompleter)
    }
    
    public func clearSearchQuerry() -> Void {
        if !self.searchQuery.isEmpty{
            self.searchQuery.removeAll()
        }
    }
    
    // Initiate a map search using fully formed address strings provided by the search completion object
    public func startSearch(_ completion: MKLocalSearchCompletion, _ region: MKCoordinateRegion = DefaultRegion()) -> Void {
        let searchRequest = MKLocalSearch.Request(completion: completion)
        
        // Takes an optional region to narrow the address search to a specific region
        searchRequest.region = region
        
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { response, error in
            guard let placemark = response?.mapItems[0].placemark else {
                return print("MKLocalSearch encountered an error: \(String(describing: error?.localizedDescription))")
            }
            
            self.mapPlacemark = placemark
        }
    }
    
    // Allows clients to update the search query, without referencing it directly via the class'
    // public interface.
    public func updateSearchQuery(_ newSearchQuerry: String) -> Void {
        searchQuery = newSearchQuerry
    }
    
    // Returns a map coordinate region, if the search request was successful. This method should be called,
    // only when the mapPlacemark object signals that it's state has changed, otherwise it may return the
    // default region.
    public func getPlacemarkCoordinateRegion() -> MKCoordinateRegion {
    
        if self.mapPlacemark?.coordinate == nil {
            return DefaultRegion()
        } else {
            return MKCoordinateRegion(center: self.mapPlacemark?.coordinate ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        }
    }
    
    // Set the search completion array to empty if the search querry is empty or an error is captured
    internal func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        if let error = error as NSError? {
            print("MKLocalSearchCompleter encountered an error: \(error.localizedDescription). The query fragment is: \"\(self.searchCompleter.queryFragment)\"")
        }
        
        // Clear the last search completion list
        self.searchCompletion = []
    }
    
    // Runs every time a new set of results is returned by the MapKit API when the search querry is modified
    internal func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.searchCompletion = searchCompleter.results
    }
}

extension DLocationSearch: Identifiable {
    
}
