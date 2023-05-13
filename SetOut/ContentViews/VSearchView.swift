//
//  VSearchView.swift
//  SetOut
//
//  Created by Svetoslav Angelov on 02/01/2023.
//

import SwiftUI

/*
    View which contains a custom search bar and list of search results. Users can
    search for specific point of interest on the map and view them as a list.
 */
struct VSearchView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            Text("Search")
                .font(.title3)
                .foregroundColor(Color("primary"))
                .bold()
                .padding()
            
            HStack(spacing: 10.0){
                CSearchBar()
                CUserLocation()
            }
            CSearchList()
        }
    }
}

struct VSearchView_Previews: PreviewProvider {
    static var previews: some View {
        VSearchView()
            .environmentObject(DNavigationStack())
            .environmentObject(DCardPosition())
            .environmentObject(DLocationManager())
            .environmentObject(DLocationSearch())
            .environmentObject(DMapPlacemark())
    }
}
