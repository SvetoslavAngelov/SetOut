//
//  ROptionsRow.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 10/09/2022.
//

import SwiftUI

/*
    Describes the a row in the route options menu, where the user
    specifies the route parameters via a slider.
 */
struct RRouteOptionsRow: View {
    @State private var sliderInput: Double
    @State private var isEditing: Bool
    
    private var screenSize: CGFloat
    private var sliderRange: Double
    private var imageLiteral: String
    private var stringSpecifier: String
    private var unitMeasure: String
    
    init(screenSize: CGFloat, sliderInput: Double, isEditing: Bool, sliderRange: Double, imageLiteral: String, stringSpecifier: String, unitMeasure: String)
    {
        self.screenSize = screenSize
        self.sliderInput = sliderInput
        self.isEditing = isEditing
        self.sliderRange = sliderRange
        self.imageLiteral = imageLiteral
        self.stringSpecifier = stringSpecifier
        self.unitMeasure = unitMeasure
    }
    
    var body: some View {
            
        HStack(alignment: .center, spacing: 10.0){
                Text(Image(systemName: imageLiteral))
                    .font(.title2)
                    .foregroundColor(Color("primary"))
                    .frame(width: screenSize*0.2)
                
                Slider(
                    value: $sliderInput,
                    in: 0...sliderRange,
                    onEditingChanged: {
                        editing in isEditing = editing
                    })
                    .preferredColorScheme(.dark)
                    .frame(width: screenSize*0.5, height: 0.0, alignment: .leading)
                
                Text("\(sliderInput, specifier: stringSpecifier) \(unitMeasure)")
                    .font(.body)
                    .foregroundColor(Color("primary"))
                    .frame(width: screenSize*0.2)
            }
    }
}

struct RRouteOptionsRow_Previews: PreviewProvider {
    static var previews: some View {
        RRouteOptionsRow(screenSize: 380.0, sliderInput: 5.0, isEditing: false, sliderRange: 10, imageLiteral: "figure.walk.circle.fill", stringSpecifier: "%.1f", unitMeasure: "km")
    }
}
