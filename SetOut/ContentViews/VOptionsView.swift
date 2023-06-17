//
//  VOptionsView.swift
//  SetOut
//
//  Created by Svetoslav Angelov on 10/09/2022.
//

import SwiftUI
import MapKit

/*
    The options view allows users to specify additional parameters
    which are used to build the final itinerary (route), including:
    1. Time available
    2. Distance to cover
    3. Tourist attractions to include in the itinerary
 */

struct VOptionsView: View {

    var screenWidth: CGFloat
    var screenHeight: CGFloat
    
    @EnvironmentObject var slidingCardPosition: DCardPosition
    @EnvironmentObject var navigationStack: DNavigationStack
    @EnvironmentObject var mapPlacemark: DMapPlacemark
    
    @State var attractionsOutline: [DAttractionOutline] = [DAttractionOutline()]
    @State var startLocationName = "Loading..."
    
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
                    ForEach(attractionsOutline) { result in
                        RTopAttractions(screenWidth: screenWidth, touristAttraction: result)
                    }
                }.frame(height: screenHeight * 0.5)
            }
        }.onAppear{
            startLocationName = mapPlacemark.name
        }.onChange(of: mapPlacemark.name) {_ in
            startLocationName = mapPlacemark.name
        }.task {
            do {
                attractionsOutline = try await getListOfAttractions()
            } catch {
                print("Failed to fetch user: \(error)")
            }
        }
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

struct VOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{ screen in
            VOptionsView(screenWidth: screen.size.width, screenHeight: screen.size.height)
                .edgesIgnoringSafeArea(.bottom)
                .environmentObject(DCardPosition())
                .environmentObject(DNavigationStack())
                .environmentObject(DMapPlacemark())
        }
    }
}
