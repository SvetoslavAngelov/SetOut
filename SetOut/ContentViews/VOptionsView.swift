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

    @EnvironmentObject var navigationStack: DNavigationStack
    @EnvironmentObject var slidingCardPosition: DCardPosition
    @EnvironmentObject var mapPlacemark: DMapPlacemark
    
    @State var attractionsOutline: [DAttractionOutline] = [DAttractionOutline()]
    
    @State var startLocationName = "Loading..."
    
    var body: some View{
        
        VStack(alignment: .leading, spacing: 10.0){
            Text("Start Location")
                .font(.title3)
                .foregroundColor(Color("primary"))
                .bold()
                .padding()
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 20.0)
                    .foregroundColor(Color(.white))
                    .frame(width: 240.0, height: 60.0)
                    .shadow(color: Color(.gray), radius: 0.5, x: 0.5, y: 1.0)
                
                HStack(alignment: .center, spacing: 10.0){
                    Text(startLocationName)
                        .frame(width: 230.0, alignment: .leading)
                        .font(.subheadline)
                        .foregroundColor(Color("primary"))
                        .bold()
                        .padding(.leading)
                    
                    Button {
                        returnToSearchView()
                    } label: {
                        Text("\(Image(systemName: "magnifyingglass"))")
                            .font(.title2)
                    }.buttonStyle(.borderedProminent)
                    
                    Button {
                        startRoutePlan()
                    } label: {
                        Text("\(Image(systemName: "compass.drawing"))")
                            .font(.title2)
                    }.buttonStyle(.borderedProminent)
                }
            }

            Text("Options")
                .font(.title3)
                .foregroundColor(Color("primary"))
                .bold()
                .padding()
            
            CRouteOptions()
            
            Text("Top Attractions")
                .font(.title3)
                .foregroundColor(Color("primary"))
                .bold()
                .padding()
            
            ScrollView{
                ForEach(attractionsOutline) { result in
                    RAttractionRow(touristAttraction: result)
                }
            }.frame(width: 360.0, height: 420.0)
        }.onAppear{
            startLocationName = mapPlacemark.name
            slidingCardPosition.updatePosition(newPosition: .bottom)
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
    
    private func returnToSearchView() -> Void {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            navigationStack.navigateTo(.searchView)
            slidingCardPosition.updatePosition(newPosition: .bottom)
        }
    }
    
    private func startRoutePlan() -> Void {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            navigationStack.navigateTo(.itineraryView)
            slidingCardPosition.updatePosition(newPosition: .middle)
        }
    }
}

struct VOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        VOptionsView()
            .environmentObject(DNavigationStack())
            .environmentObject(DMapPlacemark())
            .environmentObject(DCardPosition())
    }
}
