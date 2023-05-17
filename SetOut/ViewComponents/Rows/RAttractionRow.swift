//
//  RAttractionRow.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 03/01/2023.
//

import SwiftUI

struct RAttractionRow: View {
    
    var touristAttraction: DAttractionOutline

    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 20.0)
                .foregroundColor(Color(.white))
                .frame(width: 360.0, height: 60.0)
                .shadow(color: Color(.gray), radius: 0.5, x: 0.5, y: 1.0)
            
            HStack(alignment: .center, spacing: 10.0) {
                touristAttraction.attractionImage
                    .resizable()
                    .frame(width: 40.0, height: 40.0)
                    .cornerRadius(50.0)

                Text(touristAttraction.name)
                    .foregroundColor(Color("primary"))
                    .font(.subheadline)
                    .bold()
                    .frame(width: 120.0, alignment: .leading)
                
                Text(touristAttraction.isOpen ? "Open" : "Closed")
                    .foregroundColor(touristAttraction.isOpen ? .green : .red)
                    .frame(width: 60.0, alignment: .leading)
                
                HStack{
                    Text("\(touristAttraction.rating, specifier: "%.1f")")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(Color("primary"))
                    
                    Text("\(Image(systemName: "star.fill"))")
                        .foregroundColor(.orange)
                }.frame(width: 60.0, alignment: .leading)

                Button {
                    likeAttraction()
                } label: {
                    Text("\(Image(systemName: "heart"))")
                        .foregroundColor(.pink)
                        .font(.title2)
                }
            }
        }
    }
    
    private func likeAttraction() -> Void {
        // Add the attraction to a list of liked attractions, later to be
        // included in the final itinerary.
    }
    
    private func openDetailedView() -> Void {
        // Transition to a detailed view with a description of the attraciton.
    }
}

struct RAttractionRow_Previews: PreviewProvider {
    static var previews: some View {
        RAttractionRow(touristAttraction: DAttractionOutline())
    }
}
