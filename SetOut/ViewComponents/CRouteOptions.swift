//
//  CRouteOptions.swift
//  SetOut
//
//  Created by Svetoslav Angelov on 10/09/2022.
//

import SwiftUI

/*
    A view component which contains the route options users
    have when defining a route.
 */
struct CRouteOptions: View {
    var body: some View {
        ZStack(alignment: .leading){
            RoundedRectangle(cornerRadius: 20.0)
                .foregroundColor(Color(.white))
                .frame(width: 360.0, height: 160.0)
                .shadow(color: Color(.gray), radius: 0.5, x: 0.5, y: 1.0)
        
            VStack(alignment: .leading, spacing: 20.0){
                RRouteOptionsRow(screenSize: 150.0, sliderInput: 5.0, isEditing: false, sliderRange: 10.0, imageLiteral: "figure.walk.circle.fill", stringSpecifier: "%.1f", unitMeasure: "km")
            
                RRouteOptionsRow(screenSize: 150.0, sliderInput: 4.0, isEditing: false, sliderRange: 8.0, imageLiteral: "person.crop.circle.badge.clock.fill", stringSpecifier: "%.1f", unitMeasure: "hours")
            }.padding(.leading)
        }
    }
}

struct CRouteOptions_Previews: PreviewProvider {
    static var previews: some View {
        CRouteOptions()
    }
}
