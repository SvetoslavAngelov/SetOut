//
//  COptionsView.swift
//  SetOut
//
//  Created by Svetoslav Angelov on 05/06/2023.
//

import SwiftUI

struct COptionsView: View {
   
    var screenWidth: CGFloat
    var screenHeight: CGFloat
    
    var body: some View {
        
        CSlidingCard(width: screenWidth, height: screenHeight, alignment: .top){
            
            VStack(alignment: .leading, spacing: 10.0){
                VStack(alignment: .center){
                    RoundedRectangle(cornerRadius: 10.0)
                        .frame(width: 40.0, height: 4.0)
                        .foregroundColor(.black)
                }
                    .padding(.top)
                    .frame(width: screenWidth)
                    .border(.orange)
                
                Text("Start Location")
                    .font(.title2)
                    .foregroundColor(Color("primary"))
                    .bold()
                    .padding()
                
                CSummaryCard(screenWidth: screenWidth, summaryText: "Current Location", icon: "arrow.forward.circle.fill", navigateTo: .itineraryView)
            }

        }
    }
}

struct COptionsView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{ screen in
            COptionsView(screenWidth: screen.size.width, screenHeight: screen.size.height)
        }
            .edgesIgnoringSafeArea(.bottom)
            .environmentObject(DCardPosition())
    }
}
