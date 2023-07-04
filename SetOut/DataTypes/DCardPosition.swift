//
//  DCardProperties.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 27/12/2022.
//

import Foundation
import SwiftUI

/*
    Helper class which stores and updates the position of the main
    sliding card component. This class defines the Y position the
    card snaps to and exposes helper functions to update the card's
    position from other parent views.
 */

enum DPosition: Double {
    
    // The screen size depends on the iPhone model.
    // The card Y position is calculated as % of
    // the screen height. For example, with a screen size
    // of 1000 pt, the middle position is y = 1000 * 0.4,
    // while the top position is y = 1000 * 0.0, or a Y of 0 (origin).
    
    case top = 0.0
    case middle = 0.4
    case bottom = 0.68
}

class DCardPosition: ObservableObject {
    
    @Published var position = DPosition.bottom
    @Published var withAnimaiton = false
    
    func updatePositionPostDrag(dragGestureValue: DragGesture.Value, maxTranslationSize: CGSize) -> Void {
        
        if dragGestureValue.translation.height > 0 && abs(dragGestureValue.predictedEndTranslation) > maxTranslationSize {
            
            // Large move down
            position = .bottom
        } else if dragGestureValue.translation.height < 0 && abs(dragGestureValue.predictedEndTranslation) > maxTranslationSize {
            
            // Large move up
            position = .top
        } else if dragGestureValue.translation.height < 0 && abs(dragGestureValue.predictedEndTranslation) <= maxTranslationSize {
            
            // Small move up
            switch position {
            case .top:
                break
            case .middle:
                position = .top
            case .bottom:
                position = .middle
            }
        } else {
            
            // Small move down
            switch position {
            case .top:
                position = .middle
            case .middle:
                position = .bottom
            case .bottom:
                break
            }
        }
        
        // Reset animaiton
        withAnimaiton.toggle()
    }
    
    func updatePosition(newPosition: DPosition) -> Void {
        position = newPosition
        
        // Reset animation
        withAnimaiton.toggle()
    }
    
}

