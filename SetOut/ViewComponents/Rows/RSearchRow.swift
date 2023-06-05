//
//  RSearchRow.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 19/09/2022.
//

import SwiftUI
import MapKit

struct RSearchRow: View {
    
    private var locationTitle: String
    private var locationSubtitle: String
    
    var screenWidth: CGFloat
    
    init(locationItem: MKLocalSearchCompletion, screenWidth: CGFloat) {
        
        self.locationTitle = locationItem.title
        let lastCommaIndex = locationItem.subtitle.lastIndex(of: ",") ?? locationItem.subtitle.endIndex
        self.locationSubtitle = String(locationItem.subtitle[..<lastCommaIndex])
        self.screenWidth = screenWidth
    }
    
    init(title: String, subtitle: String,  screenWidth: CGFloat) {
        self.locationTitle = title
        self.locationSubtitle = subtitle
        self.screenWidth = screenWidth
    }
    
    var body: some View {
        VStack{
            HStack(alignment: .center){
                VStack(alignment: .leading, spacing: 10.0){
                        Text(locationTitle)
                            .font(.subheadline)
                            .foregroundColor(Color("primary"))
                            .bold()
                            .frame(width: screenWidth*0.8, alignment: .leading)
                            .padding([.top,.leading])
                        Text(locationSubtitle)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .frame(width: screenWidth*0.8, alignment: .leading)
                            .padding(.leading)
                }
                
                Text("\(Image(systemName: "chevron.right"))")
            }
            
            RoundedRectangle(cornerRadius: 10.0)
                .frame(width: screenWidth*0.9, height: 2.0)
                .foregroundColor(.gray)
        }
            .frame(width: screenWidth)
    }
}

struct RSearchRow_Previews: PreviewProvider {
    static var previews: some View {
        RSearchRow(title: "Royal Observatory Greenwich", subtitle: "Address", screenWidth: 380.0)
    }
}

