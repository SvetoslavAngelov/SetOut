//
//  RTopAttractions.swift
//  SetOut
//
//  Created by Svetoslav Angelov on 06/06/2023.
//

import SwiftUI

struct RTopAttractions: View {
    
    var screenWidth: CGFloat
    var touristAttraction: DAttractionOutline
    
    var body: some View {
        VStack {
            HStack(alignment: .center,spacing: 10.0) {
                Button {
                    likeAttraction()
                } label: {
                    Text("\(Image(systemName: "heart"))")
                        .foregroundColor(.gray)
                        .font(.title2)
                }
                
                touristAttraction.attractionImage
                    .resizable()
                    .frame(width: 80.0, height: 80.0)
                    .cornerRadius(10.0, corners: [.topLeft, .bottomLeft])
                    .overlay{
                        RoundedCorner(radius: 10.0, corners: [.topLeft, .bottomLeft]).stroke(.gray)
                    }
                
                VStack(alignment: .leading, spacing: 10.0){
                    Text(touristAttraction.name)
                        .foregroundColor(Color("primary"))
                        .font(.title3)
                        .frame(width: screenWidth * 0.6, alignment: .leading)
                    
                    Text(touristAttraction.isOpen ? "Open" : "Closed")
                        .foregroundColor(touristAttraction.isOpen ? .green : .red)
                        .font(.subheadline)
                    
                    HStack{
                        Text("\(touristAttraction.rating, specifier: "%.1f")")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(Color("primary"))
                        
                        Text("\(Image(systemName: "star.fill"))")
                            .foregroundColor(.orange)
                            .font(.subheadline)
                    }
                }
            }
            
            RoundedRectangle(cornerRadius: 10.0)
                .frame(width: screenWidth*0.9, height: 2.0)
                .foregroundColor(.gray)
            
        }.frame(width: screenWidth)
    }
    
    private func likeAttraction() -> Void {
        // Add the attraction to a list of liked attractions, later to be
        // included in the final itinerary.
    }
}

struct RTopAttractions_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { screen in
            RTopAttractions(screenWidth: screen.size.width, touristAttraction: DAttractionOutline())
        }
    }
}
