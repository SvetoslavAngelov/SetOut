//
//  CFilterButton.swift
//  SetOut
//
//  Created by Svetoslav Angelov on 06/06/2023.
//

import SwiftUI

struct CFilterSection: View {
    
    @State var isTimeActive = false
    
    var screenWidth: CGFloat
    
    
    var body: some View {
        VStack(spacing: 40.0){
            HStack(spacing: 10.0){
                
                Text("Distance")
                    .frame(width: (screenWidth - 30.0)/2, height: 60.0)
                    .font(.title3)
                    .foregroundColor(!isTimeActive ? .blue : .gray)
                    .background(!isTimeActive ? Color(red: 0.44, green: 0.84, blue: 1, opacity: 0.25) : .white)
                    .animation(.easeInOut(duration: 0.1), value: !isTimeActive)
                    .cornerRadius(10.0, corners: [.topLeft, .bottomLeft])
                    .overlay{
                        RoundedCorner(radius: 10.0, corners: [.topLeft, .bottomLeft]).stroke(!isTimeActive ? .blue : .gray)
                    }
                    .onTapGesture {
                        withAnimation{
                            if isTimeActive == true {
                                isTimeActive.toggle()
                            }
                        }
                    }
                
                Text("Time")
                    .frame(width: (screenWidth - 30.0)/2, height: 60.0)
                    .font(.title3)
                    .foregroundColor(isTimeActive ? .blue : .gray)
                    .background(isTimeActive ? Color(red: 0.44, green: 0.84, blue: 1, opacity: 0.25) : .white)
                    .animation(.easeInOut(duration: 0.1), value: isTimeActive)
                    .cornerRadius(10.0, corners: [.topRight, .bottomRight])
                    .overlay{
                        RoundedCorner(radius: 10.0, corners: [.topRight, .bottomRight]).stroke(isTimeActive ? .blue : .gray)
                    }
                    .onTapGesture {
                        withAnimation{
                            if isTimeActive == false {
                                isTimeActive.toggle()
                            }
                        }
                    }
            }
            
            if isTimeActive {
                RRouteOptionsRow(screenSize: screenWidth, sliderInput: 4.0, isEditing: false, sliderRange: 8.0, imageLiteral: "person.crop.circle.badge.clock.fill", stringSpecifier: "%.1f", unitMeasure: "hr")
            } else {
                RRouteOptionsRow(screenSize: screenWidth, sliderInput: 5.0, isEditing: false, sliderRange: 10.0, imageLiteral: "figure.walk.circle.fill", stringSpecifier: "%.1f", unitMeasure: "km")
            }
            
        }.frame(width: screenWidth)
    }
}

struct CFilterSection_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { screen in
            CFilterSection(screenWidth: screen.size.width)
        }
    }
}
