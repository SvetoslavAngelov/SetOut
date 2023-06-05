//
//  VMainView.swift
//  SetOut
//
//  Created by Svetoslav Angelov on 06/12/2022.
//

import SwiftUI
import MapKit

/*
    The main view is comprised of the following sub views:
    1. Map view - the background of the app, it listens for changes to the locationSearch,
    locationManager and mapPlacemark objects and updates the map accordingly.
    2. Search view - allows users to set the start location of their route.
    3. Options view - set route planning settings, including distance to cover and
    time available per route.
    4. Itinerary view - the generated route based on the parameters provided by the user. 
 */

struct VMainView: View {
    
    @EnvironmentObject var navigationStack: DNavigationStack
    
    var body: some View {
        ZStack{
            CMapView().preferredColorScheme(.light)
            
            GeometryReader{ screen in
                
                VStack{
                    switch navigationStack.stack {
                    case .searchView:
                        VSearchView(screenWidth: screen.size.width)
                    case .optionsView:
                        withAnimation{
                            VOptionsView()
                                .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom)))
                        }
                    case .itineraryView:
                        withAnimation{
                            VItineraryView()
                                .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom)))
                        }
                        
                    }
                }
            }
        }
    }
}

struct VMainView_Previews: PreviewProvider {
    static var previews: some View {
        VMainView()
            .environmentObject(DNavigationStack())
            .environmentObject(DCardPosition())
            .environmentObject(DLocationManager())
            .environmentObject(DLocationSearch())
            .environmentObject(DMapPlacemark())
    }
}
