//
//  DNavigationStack.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 01/01/2023.
//

import Foundation
import SwiftUI

enum DStack: Int {
    case searchView = 0
    case optionsView
    case itineraryView
}

class DNavigationStack: ObservableObject {
    
    @Published var stack = DStack.searchView
    @Published var visited: Set = [DStack.searchView]

    public func navigateTo(_ newView: DStack) -> Void {
        withAnimation{
            self.stack = newView
            if newView == DStack.searchView {
                
                // When users go back to Search, the Options and Itinerary view are no longer accessible
                self.visited.removeAll(keepingCapacity: true)
            }
            
            self.visited.insert(newView)
        }
    }
}
