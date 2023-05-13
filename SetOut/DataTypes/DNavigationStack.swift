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

    public func navigateTo(_ newView: DStack) -> Void {
        self.stack = newView
    }
}
