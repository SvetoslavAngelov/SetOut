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
    @EnvironmentObject var httpRequest: DHttpRequest
    @EnvironmentObject var locationService: DLocationService
    @EnvironmentObject var locationSearch: DLocationSearch
    
    var body: some View {
        ZStack{
            CMapView().preferredColorScheme(.light)
            
            GeometryReader{ screen in
                ZStack {
                
                    VStack{
                        switch navigationStack.stack {
                            case .searchView:
                                VSearchView(screenWidth: screen.size.width)
                                .frame(height: screen.size.height + screen.safeAreaInsets.bottom)
                            case .optionsView:
                                withAnimation{
                                    COptionsView(screenWidth: screen.size.width, screenHeight: screen.size.height + screen.safeAreaInsets.bottom)
                                        .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom)))
                                }
                            case .itineraryView:
                                withAnimation{
                                    VItineraryView(screenWidth: screen.size.width, screenHeight: screen.size.height + screen.safeAreaInsets.bottom)
                                        .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom)))
                                }
                            }
                    }.safeAreaInset(edge: .top){
                        STransparentCard(width: screen.size.width, height: 0.0)
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
            .environmentObject(DHttpRequest())
            .environmentObject(DLocationService())
            .environmentObject(DLocationSearch())
    }
}
