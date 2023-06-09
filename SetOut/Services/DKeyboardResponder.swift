//
//  DKeyboardResponder.swift
//  SetOut
//
//  Created by Svetoslav Angelov on 07/06/2023.
//

import Foundation
import Combine
import SwiftUI

class DKeyboardResponder: ObservableObject {
    
    @Published var keyboardHeight: CGFloat = 0
    
    var cancellables = Set<AnyCancellable>()

    init() {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .map { $0.keyboardHeight }
            .assign(to: &$keyboardHeight)

        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
            .assign(to: &$keyboardHeight)
    }
}

extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}
