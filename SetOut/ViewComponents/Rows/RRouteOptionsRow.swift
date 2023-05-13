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
    
    private var sliderRange: Double
    private var description: String
    private var imageLiteral: String
    private var stringSpecifier: String
    private var unitMeasure: String
    
    init(sliderInput: Double, isEditing: Bool, sliderRange: Double, description: String, imageLiteral: String, stringSpecifier: String, unitMeasure: String)
    {
        self.sliderInput = sliderInput
        self.isEditing = isEditing
        self.sliderRange = sliderRange
        self.description = description
        self.imageLiteral = imageLiteral
        self.stringSpecifier = stringSpecifier
        self.unitMeasure = unitMeasure
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0){
            Text(description)
                .font(.subheadline)
                .bold()
                .foregroundColor(Color("primary"))
            
            HStack{
                Text(Image(systemName: imageLiteral))
                    .font(.title2)
                    .foregroundColor(Color("primary"))
                
                Slider(
                    value: $sliderInput,
                    in: 0...sliderRange,
                    onEditingChanged: {
                        editing in isEditing = editing
                    })
                .preferredColorScheme(.dark)
                .frame(width: 180.0, height: 0.0, alignment: .leading)
                
                Text("\(sliderInput, specifier: stringSpecifier) \(unitMeasure)")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(Color("primary"))
            }
        }
    }
}

struct RRouteOptionsRow_Previews: PreviewProvider {
    static var previews: some View {
        RRouteOptionsRow(sliderInput: 5.0, isEditing: false, sliderRange: 10, description: "Distance to walk", imageLiteral: "figure.walk.circle.fill", stringSpecifier: "%.1f", unitMeasure: "km")
    }
}
