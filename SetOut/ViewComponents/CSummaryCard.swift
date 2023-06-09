//
//  CSummaryCard.swift
//  SetOut
//
//  Created by Svetoslav Angelov on 05/06/2023.
//

import SwiftUI

struct CSummaryCard: View {
    
    var screenWidth: CGFloat
    var summaryText: String
    var icon: String
    var navigateTo: DStack
    
    @EnvironmentObject var navigationStack: DNavigationStack
    
    var body: some View {
        VStack(spacing: 20.0){
            
            // Search Bar
            ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: 0.0)
                    .foregroundColor(Color(.white))
                    .frame(width: screenWidth - 20.0, height: 50.0)
                    .overlay{
                        RoundedRectangle(cornerRadius: 10.0).stroke(.gray)
                    }
                
                // Search field
                HStack(spacing: 20.0){
                    Text(summaryText)
                        .font(.body)
                        .frame(width: screenWidth - 130, height: 50.0, alignment: .leading)

                    RoundedRectangle(cornerRadius: 10.0)
                        .frame(width: 4.0, height: 30.0)
                        .foregroundColor(.gray)
                    
                    Button("\(Image(systemName: icon))"){
                            navigationStack.navigateTo(navigateTo)
                        }
                        .foregroundColor(.blue)
                        .font(.title2)
                }.padding(.leading)
            }
            
        }
            .frame(width: screenWidth)
    }
}

struct CSummaryCard_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { screen in
            CSummaryCard(screenWidth: screen.size.width, summaryText: "Current location", icon: "arrow.forward.circle.fill", navigateTo: .itineraryView)
        }.environmentObject(DNavigationStack())
    }
}
