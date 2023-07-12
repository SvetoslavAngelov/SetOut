//
//  CSearchList.swift
//  SetOut
//
//  Created by Svetoslav Angelov on 30/12/2022.
//

import SwiftUI
import MapKit

/*
    View component which returns the list of location search results,
    based on the characters entered by the user in the CSearchCard. 
 */

struct CSearchList: View {
    
    var screenWidth: CGFloat
    
    @EnvironmentObject var navigationStack: DNavigationStack
    @EnvironmentObject var locationSearch: DLocationSearch
    @EnvironmentObject var locationService: DLocationService
    
    @State var searchResults: [MKLocalSearchCompletion] = []
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 0.0) {
                ForEach(searchResults.prefix(5), id: \.self) { location in
                    Button {
                        startSearch(location)
                        navigationStack.navigateTo(.optionsView)
                    } label: {
                        RSearchRow(locationItem: location, screenWidth: screenWidth)
                    }.buttonStyle(.plain)
                }
            }.onChange(of: locationSearch.searchCompletion) {_ in
                searchResults = locationSearch.searchCompletion
            }
        }.background(.white)
    }
    
    private func startSearch(_ completion: MKLocalSearchCompletion) -> Void {
        Task {
            do {
                let searchResult = try await locationSearch.startSearchAsync(completion)
                
                DispatchQueue.main.async {
                    locationService.setMapPlacemark(newPlacemark: searchResult)
                }
            } catch {
                print("Search error")
            }
        }
    }
}

struct CSearchList_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{ screen in
            CSearchList(screenWidth: screen.size.width)
                .environmentObject(DNavigationStack())
                .environmentObject(DLocationSearch())
                .environmentObject(DLocationService())
        }
    }
}
