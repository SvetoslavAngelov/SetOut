//
//  CSlidingCard.swift
//  SetOut
//
//  Created by Svetoslav Angelov on 27/12/2022.
//

import SwiftUI

/*
    This component describes a sliding card which snaps to bottom, mid and
    top screen positions. For the Y position calculation and snap thresholds
    see DCardPosition.swift.
 */

struct CSlidingCard<Content: View> : View {
    
    // Content of other views
    private var content: () -> Content
    
    // Optional action executed at the end of each drag action
    private var action: (() -> Void)
    
    // Card dimensions
    private var width: CGFloat
    private var height: CGFloat
    private var alignment: Alignment
    
    // The position at which the card is snapped in
    @EnvironmentObject private var cardPosition: DCardPosition
    
    // The size of the drag gesture.
    @GestureState private var dragSize = CGSize(width: 0.0, height: 0.0)
    
    /*
        Class member function interface
     */
    
    // Default initialiser, without an additional action specified
    init(width: CGFloat, height: CGFloat, alignment: Alignment, @ViewBuilder content: @escaping () -> Content) {
        
        self.width = width
        self.height = height
        self.alignment = alignment
        
        self.action = {}
        
        self.content = content
    }
    
    // Initialiser with an additional action attached to each drag gesture
    init(width: CGFloat, height: CGFloat, alignment: Alignment, action: @escaping () -> Void,@ViewBuilder content: @escaping () -> Content) {
        
        self.width = width
        self.height = height
        self.alignment = alignment
        
        self.action = action
        
        self.content = content
    }
    
    private func setCardPosition(dragGestureValue: DragGesture.Value) -> Void {
        
        cardPosition.updatePositionPostDrag(dragGestureValue: dragGestureValue, maxTranslationSize: CGSize(width: 0.0, height: self.height))
        
        // Trigger action if set during card initialisation
        action()
    }
    
    /*
     View body interface
     */
    
    var body: some View {
        
        let dragAction = DragGesture()
            .updating($dragSize) {
                dragAction, state, transaction in state = dragAction.translation
            }
            .onChanged{_ in
                cardPosition.withAnimaiton.toggle()
            }
            .onEnded(setCardPosition)
        
        return ZStack(alignment: alignment) {
            
            // Card material
            SRegularCard(width: self.width, height: self.height)
            
            // Content views
            content()
        }
        // TODO replace the y check with card's latest position
        .offset(x: 0.0, y: cardPosition.position == .top && dragSize.height < 0 ? 0.0 : dragSize.height)
        .gesture(dragAction)
        .onTapGesture {
            cardPosition.position = .top
            cardPosition.withAnimaiton.toggle()
        }
        .offset(x: 0.0, y: self.height * cardPosition.position.rawValue)
        .animation(.interpolatingSpring(stiffness: 300.0, damping: 200.0, initialVelocity: 20.0), value: cardPosition.withAnimaiton)
    }
}

struct CSlidingCard_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{ screen in
            CSlidingCard(width: screen.size.width, height: screen.size.height, alignment: .top){
            }
        }.edgesIgnoringSafeArea(.bottom).environmentObject(DCardPosition())
    }
}

