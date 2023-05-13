//
//  CSearchList.swift
//  SetOut
//
//  Created by Svetoslav Angelov on 30/12/2022.
//

import SwiftUI
import MapKit

struct CSearchList: View {
    
    @EnvironmentObject var navigationStack: DNavigationStack
    @EnvironmentObject var locationSearch: DLocationSearch
    @EnvironmentObject var slidingCardPosition: DCardPosition
    
    @State var searchResults: [MKLocalSearchCompletion] = []
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10.0){
            
            ForEach(searchResults.prefix(5), id: \.self) { location in
                Button {
                    locationSearch.startSearch(location)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                        navigationStack.navigateTo(.optionsView)
                        slidingCardPosition.updatePosition(newPosition: .bottom)
                    }
                } label: {
                    RSearchRow(locationItem: location)
                }.buttonStyle(.plain)
            }
        }.frame(width: 360.0)
            .onChange(of: locationSearch.searchCompletion) {_ in
                searchResults = locationSearch.searchCompletion
            }
    }
}

struct CSearchList_Previews: PreviewProvider {
    static var previews: some View {
        CSearchList()
            .environmentObject(DNavigationStack())
            .environmentObject(DLocationSearch())
            .environmentObject(DCardPosition())
    }
}
