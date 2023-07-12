//
//  COptionsView.swift
//  SetOut
//
//  Created by Svetoslav Angelov on 06/07/2023.
//

import SwiftUI

struct COptionsView: View {

    var screenWidth: CGFloat
    var screenHeight: CGFloat
    
    @EnvironmentObject var navigationStack: DNavigationStack
    @EnvironmentObject var httpRequest: DHttpRequest
    @EnvironmentObject var locationService: DLocationService
    
    @State var startLocationName: String = "Loading..."
    @State var touristAttractionList: [DAttractionOutline] = [DAttractionOutline()]
    
    var body: some View {
        
        CSlidingCard(width: screenWidth, height: screenHeight, alignment: .top){
            
            VStack(alignment: .leading, spacing: 10.0){
                VStack(alignment: .center){
                    RoundedRectangle(cornerRadius: 10.0)
                        .frame(width: 40.0, height: 4.0)
                        .foregroundColor(.black)
                }
                    .padding(.top)
                    .frame(width: screenWidth)
                
                Text("Start Location")
                    .font(.body)
                    .foregroundColor(Color("primary"))
                    .bold()
                    .padding()
                
                CSummaryCard(screenWidth: screenWidth, summaryText: startLocationName, icon: "arrow.forward.circle.fill", action: CreateItinerary)
                
                Text("Filter By")
                    .font(.body)
                    .foregroundColor(Color("primary"))
                    .bold()
                    .padding()
                
                CFilterSection(screenWidth: screenWidth)
                
                Text("Top Attractions")
                    .font(.body)
                    .foregroundColor(Color("primary"))
                    .bold()
                    .padding()
                
                ScrollView{
                    ForEach (httpRequest.isFinishedLoading ? httpRequest.serverResult : touristAttractionList) { result in
                        RTopAttractions(screenWidth: screenWidth, touristAttraction: result)
                    }
                }.frame(height: screenHeight * 0.5)
            }.onAppear{
                self.startLocationName = locationService.getMapPlacemark().name
                self.touristAttractionList = httpRequest.serverResult
            }.onChange(of: locationService.isLocationUpdated) {_ in
                loadResults(startLocation: locationService.getMapPlacemark().name)
            }.onDisappear{
                httpRequest.isFinishedLoading = false
            }
        }
    }
    
    func loadResults(startLocation: String) -> Void {
        
        // Update location name
        self.startLocationName = startLocation
        
        // Check cache first
        if let cachedResult = httpRequest.searchResultCache.Get(key: startLocation) {
            touristAttractionList = cachedResult
            return
        }
        
        // Call server otherwise
        httpRequest.fetchFromServer(startLocation: startLocation)
    }
    
    private func CreateItinerary() -> Void {
        // Navigate to the Itinerary view
        navigationStack.navigateTo(.itineraryView)
        
        // Reset Options view card to its default position
        
        // Request a new itinerary with the following params:
            // - Starting location coordinates
            // - "Cost"
            // - "Distance/Time"
            // - ID of favourite attractions
    }
}

struct COptionsView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{ screen in
            VOptionsView(screenWidth: screen.size.width, screenHeight: screen.size.height)
                .edgesIgnoringSafeArea(.bottom)
                .environmentObject(DNavigationStack())
                .environmentObject(DHttpRequest())
                .environmentObject(DLocationService())
        }
    }
}
