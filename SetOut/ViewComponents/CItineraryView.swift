//
//  CItineraryView.swift
//  SetOut
//
//  Created by Svetoslav Angelov on 06/06/2023.
//

import SwiftUI

struct CItineraryView: View {
    
    var screenWidth: CGFloat
    var screenHeight: CGFloat
    
    @EnvironmentObject var navigationStack: DNavigationStack
    @EnvironmentObject var slidingCardPosition: DCardPosition
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
                
                CSummaryCard(screenWidth: screenWidth, summaryText: startLocationName, icon: "magnifyingglass", action: ReturnToSearch)
                
                Text("Summary")
                    .font(.body)
                    .foregroundColor(Color("primary"))
                    .bold()
                    .padding()
                
                ZStack(alignment: .leading){
                    RoundedRectangle(cornerRadius: 0.0)
                        .foregroundColor(Color(.white))
                        .frame(width: screenWidth - 20.0, height: 50.0)
                        .overlay{
                            RoundedRectangle(cornerRadius: 10.0).stroke(.gray)
                        }

                    HStack(spacing: 20.0){
                        Text("Distance 5.9 km")
                            .font(.body)
                            .frame(width: (screenWidth - 80.0)/2, height: 50.0, alignment: .leading)
                            .padding(.leading)
                        
                        RoundedRectangle(cornerRadius: 10.0)
                            .frame(width: 4.0, height: 30.0)
                            .foregroundColor(.gray)
                        
                        Text("Time 4:30 hours")
                            .font(.body)
                            .frame(width: (screenWidth - 80.0)/2, height: 50.0, alignment: .leading)
                    }
                }.frame(width: screenWidth)
                
                Text("Itinerary")
                    .font(.body)
                    .foregroundColor(Color("primary"))
                    .bold()
                    .padding()
                
                ScrollView{
                    ForEach(attractionsOutline.indices, id: \.self) { index in
                        let result = attractionsOutline[index]
                        RItineraryAttraction(id: index+1, screenWidth: screenWidth, touristAttraction: result)
                    }
                }.frame(height: screenHeight * 0.54)
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
    
    private func ReturnToSearch() -> Void {
        
        // Return to the search view
        navigationStack.navigateTo(.searchView)
    }
}

struct CItineraryView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{ screen in
            CItineraryView(screenWidth: screen.size.width, screenHeight: screen.size.height)
                .environmentObject(DNavigationStack())
                .environmentObject(DCardPosition())
                .environmentObject(DMapPlacemark())
        }
    }
}
