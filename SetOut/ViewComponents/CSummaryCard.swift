//
//  CSummaryCard.swift
//  SetOut
//
//  Created by Svetoslav Angelov on 05/06/2023.
//

import SwiftUI

struct CSummaryCard: View {
    
    // Card properties
    private var screenWidth: CGFloat
    private var summaryText: String
    private var icon: String
    
    // Optional action to be performed when the button is pressed
    private var action : (()->Void)
    
    // Default initialiser, without an additional action specified
    init(screenWidth: CGFloat, summaryText: String, icon: String) {
        self.screenWidth = screenWidth
        self.summaryText = summaryText
        self.icon = icon
        self.action = {}
    }
    
    // Initialiser which takes an explicit action to be performed when the view button is pressed
    init(screenWidth: CGFloat, summaryText: String, icon: String, action: @escaping () -> Void) {
        self.screenWidth = screenWidth
        self.summaryText = summaryText
        self.icon = icon
        self.action = action
    }
    
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
                            action()
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
            CSummaryCard(screenWidth: screen.size.width, summaryText: "Current location", icon: "arrow.forward.circle.fill")
        }
    }
}
