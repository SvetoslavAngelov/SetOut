//
//  CSearchCard.swift
//  SetOut
//
//  Created by Svetoslav Angelov on 01/06/2023.
//

import SwiftUI

/*
    Custom text field component which is used for location searching.
    The text entered by the user updates the DLocationSearch search
    query, which in turn triggers a new view update. 
 */

struct CSearchCard: View {
    
    @EnvironmentObject var locationSearch: DLocationSearch
    @FocusState var isFocused: Bool
    @State var searchText = ""
    
    var screenWidth: CGFloat
    
    var body: some View {
            VStack(spacing: 20.0){
                
                // Search Bar
                ZStack(alignment: .leading){
                    RoundedRectangle(cornerRadius: 10.0)
                        .foregroundColor(Color(.white))
                        .frame(width: screenWidth - 20.0, height: 60.0)
                        .shadow(color: Color(.gray), radius: 4.0, x: 1.0, y: 2.0)
                    
                    // Search field
                    HStack(spacing: 20.0){
                        Text("\(Image(systemName: "magnifyingglass"))")
                            .font(.title2)
                            .foregroundColor(.gray)
                            .padding(.leading)
                        TextField("Start location...", text: $searchText)
                            .font(.body)
                            .frame(width: screenWidth - 174, height: 50.0)
                            .focused($isFocused)
                        
                        RoundedRectangle(cornerRadius: 10.0)
                            .frame(width: 4.0, height: 40.0)
                            .foregroundColor(.gray)
                        
                        if !searchText.isEmpty {
                            Button("\(Image(systemName: "x.circle.fill"))"){
                                isFocused = false
                                clearSearchQuerry()
                            }
                                .foregroundColor(.gray)
                                .font(.title2)
                        } else {
                            CUserLocation()
                        }
                    }
                }
                
                CSearchList(screenWidth: screenWidth)
                
            }
                .frame(width: screenWidth)
                .padding(.top)
                .onChange(of: searchText) {_ in
                    if !searchText.isEmpty {
                        locationSearch.updateSearchQuery(searchText)
                    }
            }
    }
    
    private func clearSearchQuerry() -> Void {
        
        // Clear the local search text variable and the location search querry.
        locationSearch.clearSearchQuerry()
        searchText = ""
    }
}

struct CSearchCard_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader {screen in
            CSearchCard(screenWidth: screen.size.width)
        }.edgesIgnoringSafeArea(.bottom)
            .environmentObject(DLocationSearch())
    }
}
