//
//  VResultsView.swift
//  SetOut
//
//  Created by Svetoslav Angelov on 20/11/2022.
//

import SwiftUI

/*
    A view with the generated itinerary presented to the user. 
 */
struct VItineraryView: View {
    
    @EnvironmentObject var navigationStack: DNavigationStack
    @EnvironmentObject var slidingCardPosition: DCardPosition
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0){
            
            Text("Itinerary")
                .font(.title3)
                .foregroundColor(Color("primary"))
                .bold()
                .padding()
            
            HStack(spacing: 10.0){
                Button {
                    navigateToSearch()
                } label: {
                    Text("\(Image(systemName: "magnifyingglass"))")
                        .font(.title2)
                }.buttonStyle(.borderedProminent)
                
                Button {
                    navigateToOptions()
                } label: {
                    Text("\(Image(systemName: "slider.horizontal.3"))")
                        .font(.title2)
                }.buttonStyle(.borderedProminent)
            }
            
            /*ScrollView{
                ForEach(touristAttractions) { result in
                    RAttractionRow(touristAttraction: result)
                }
            }.frame(width: 360.0, height: 560.0)*/
        }
    }
    
    private func navigateToSearch() -> Void {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            navigationStack.navigateTo(.searchView)
            slidingCardPosition.updatePosition(newPosition: .bottom)
        }
    }
    
    private func navigateToOptions() -> Void {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            navigationStack.navigateTo(.optionsView)
            slidingCardPosition.updatePosition(newPosition: .top)
        }
    }
}

struct VItineraryView_Previews: PreviewProvider {
    static var previews: some View {
        VItineraryView()
            .environmentObject(DNavigationStack())
            .environmentObject(DCardPosition())
    }
}
