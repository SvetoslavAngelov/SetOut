//
//  RItineraryAttraction.swift
//  SetOut
//
//  Created by Svetoslav Angelov on 07/06/2023.
//

import SwiftUI

struct RItineraryAttraction: View {
    var id: Int
    var screenWidth: CGFloat
    var touristAttraction: DAttractionOutline
    
    var body: some View {
        VStack {
            HStack(alignment: .center,spacing: 10.0) {
                
                Text("\(id)")
                    .foregroundColor(Color("primary"))
                    .bold()
                    .font(.body)
                
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
                        .font(.body)
                        .frame(width: screenWidth * 0.6, alignment: .leading)
                    
                    Text(touristAttraction.isOpen ? "Open" : "Closed")
                        .foregroundColor(touristAttraction.isOpen ? .green : .red)
                        .font(.body)
                    
                    HStack{
                        Text("\(touristAttraction.distance, specifier: "%.1f") km")
                            .font(.body)
                            .foregroundColor(Color("primary"))
                    }
                }
            }
            
            RoundedRectangle(cornerRadius: 10.0)
                .frame(width: screenWidth*0.9, height: 2.0)
                .foregroundColor(.gray)
            
        }.frame(width: screenWidth)
    }
}

struct RItineraryAttraction_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { screen in
            RItineraryAttraction(id: 1, screenWidth: screen.size.width, touristAttraction: DAttractionOutline())
        }
    }
}
