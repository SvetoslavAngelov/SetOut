//
//  COptionsView.swift
//  SetOut
//
//  Created by Svetoslav Angelov on 05/06/2023.
//

import SwiftUI

struct COptionsView: View {
   
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
                    .font(.title3)
                    .foregroundColor(Color("primary"))
                    .bold()
                    .padding()
                
                CSummaryCard(screenWidth: screenWidth, summaryText: startLocationName, icon: "arrow.forward.circle.fill", navigateTo: .searchView)
                
                Text("Filter By")
                    .font(.title3)
                    .foregroundColor(Color("primary"))
                    .bold()
                    .padding()
                
                CFilterSection(screenWidth: screenWidth)
                
                Text("Top Attractions")
                    .font(.title3)
                    .foregroundColor(Color("primary"))
                    .bold()
                    .padding()
                
                ScrollView{
                    ForEach(attractionsOutline) { result in
                        RTopAttractions(screenWidth: screenWidth, touristAttraction: result)
                    }
                }.frame(height: screenHeight * 0.3)
            }
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
}

struct COptionsView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{ screen in
            COptionsView(screenWidth: screen.size.width, screenHeight: screen.size.height)
        }
            .edgesIgnoringSafeArea(.bottom)
            .environmentObject(DCardPosition())
            .environmentObject(DNavigationStack())
            .environmentObject(DMapPlacemark())
    }
}
