//
//  CSearchBar.swift
//  SetOut
//
//  Created by Svetoslav Angelov on 16/10/2022.
//

import SwiftUI

/*
    This is a custom search component which is similar to the built in SwiftUI,
    the main difference is the ability to set the background of the search component
    and the greater flexibility when it comes to animating the various components.
 */
struct CSearchBar: View {

    @State var searchText = ""
    @FocusState var isFocused: Bool
    
    @EnvironmentObject var locationSearch: DLocationSearch
    @EnvironmentObject var slidingCardPosition: DCardPosition
    
    @State var cancelButtonOpacity = 0.0
    
    var body : some View {
        
        VStack(alignment: .leading, spacing: 10.0){
            
            ZStack(alignment: .leading){
                
                RoundedRectangle(cornerRadius: 10.0)
                    .strokeBorder(.gray, lineWidth: 1.0)
                    .frame(width: 300.0, height: 50)
                
                // Search field
                HStack(spacing: 10.0){
                    Text("\(Image(systemName: "magnifyingglass"))")
                        .foregroundColor(.gray)
                        .padding(.leading)
                    TextField("Start location...", text: $searchText)
                        .frame(width: 200.0, height: 50.0)
                        .focused($isFocused)
                    if isFocused {
                        Button("\(Image(systemName: "x.circle.fill"))"){
                            isFocused = false
                            clearSearchQuerry()
                            
                            // Set the sliding card's position to the bottom of the screen.
                            slidingCardPosition.updatePosition(newPosition: .bottom)
                        }.foregroundColor(Color(red: 0.5, green: 0.5, blue: 0.5, opacity: self.cancelButtonOpacity))
                            .font(.title2)
                            .onAppear{
                                withAnimation(.easeIn(duration: 1.0)) {
                                    cancelButtonOpacity = 1.0
                                }
                            }
                            .onDisappear{
                                cancelButtonOpacity = 0.0
                            }
                    }
                }
            }
        }.onChange(of: searchText) {_ in
            if !searchText.isEmpty {
                locationSearch.updateSearchQuery(searchText)
            }
        }.onChange(of: slidingCardPosition.position) {_ in
            // When the text field is focused, the location of the card
            // is going to be at the top, making space for the search results
            // and the on-screen keyboard. If the location changes to any other
            // value, the on screen keyboard should be hidden so it doesn't
            // obstruct the sliding card component.
            isFocused = false
            
            clearSearchQuerry()
        }
    }

    private func clearSearchQuerry() -> Void {
        
        // Clear the local search text variable and the location search querry.
        searchText.removeAll()
        locationSearch.clearSearchQuerry()
    }
}

struct CSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            CSearchBar()
                .environmentObject(DNavigationStack())
                .environmentObject(DCardPosition())
        }
        
    }
}
