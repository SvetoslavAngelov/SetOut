//
//  SRegularCard.swift
//  SetOut
//
//  Created by Svetoslav Angelov on 28/09/2022.
//

import SwiftUI

/*
    Basic card shape component using Swift's regular material.
 */

struct SRegularCard: View {
    private var width: CGFloat
    private var height: CGFloat
    
    init(width: CGFloat, height: CGFloat){
        
        self.width = width
        self.height = height
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10.0)
            .strokeBorder(.white, lineWidth: 1.0)
            .frame(width: width, height: height)
            .background(.white)
            .cornerRadius(20.0)
            .shadow(color: Color(.gray), radius: 4.0, x: 1.0, y: 2.0)
    }
}

struct SRegularCard_Previews: PreviewProvider {
    static var previews: some View {
        SRegularCard(width: 360, height: 180)
    }
}
