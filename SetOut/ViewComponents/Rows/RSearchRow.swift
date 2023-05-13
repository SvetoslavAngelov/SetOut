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
    
    init(locationItem: MKLocalSearchCompletion) {
        
        self.locationTitle = locationItem.title
        let lastCommaIndex = locationItem.subtitle.lastIndex(of: ",") ?? locationItem.subtitle.endIndex
        self.locationSubtitle = String(locationItem.subtitle[..<lastCommaIndex])
    }
    
    init(title: String, subtitle: String) {
        self.locationTitle = title
        self.locationSubtitle = subtitle
    }
    
    var body: some View {
        
        ZStack(alignment: .leading){
            RoundedRectangle(cornerRadius: 20.0)
                .foregroundColor(Color(.white))
                .frame(width: 360.0, height: 80.0)
                .shadow(color: Color(.gray), radius: 0.5, x: 0.5, y: 1.0)
            
            VStack(alignment: .leading, spacing: 10.0){
                Text(locationTitle)
                    .font(.subheadline)
                    .foregroundColor(Color("primary"))
                    .bold()
                Text(locationSubtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .frame(height: 40.0, alignment: .topLeading)
            }.padding(.leading)
        }
    }
}

struct RSearchRow_Previews: PreviewProvider {
    static var previews: some View {
        RSearchRow(title: "Royal Observatory Greenwich", subtitle: "Address")
    }
}

