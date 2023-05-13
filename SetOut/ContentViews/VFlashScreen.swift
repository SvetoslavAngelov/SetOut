//
//  VFlashScreen.swift
//  SetOut
//
//  Created by Svetoslav Angelov on 15/10/2022.
//

import SwiftUI

/*
    A simple flash screen used to introduce the user to the app.
 */
struct VFlashScreen: View {
    
    var body: some View {
        ZStack(alignment: .center){
            background
            
            VStack{
                title
                shape
            }
        }
    }
    
    var background: some View {
        LinearGradient(
            gradient: Gradient(stops: [
                .init(color: Color(red: 0.16, green: 0.22, blue: 0.45, opacity: 1.0), location: 0.7),
                .init(color: Color(red: 0.0, green: 0.73, blue: 1.0, opacity: 1.0), location: 1.0)
            ]),
            startPoint: UnitPoint(x: 1.0, y: 1.0),
            endPoint: UnitPoint(x: -0.30, y: 0.10))
        .ignoresSafeArea()
    }
    
    var shape: some View {
        Circle()
            .fill(LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color(red: 0.95, green: 0.95, blue: 1.0, opacity: 1.0), location: 0.0),
                    .init(color: Color(red: 0.85, green: 0.55, blue: 1.0, opacity: 0.50), location: 0.50)
                ]),
                startPoint: UnitPoint(x: 0.30, y: 0.1),
                endPoint: UnitPoint(x: 1.0, y: 1.0)))
            .frame(width: 240.0, height: 240.0)
    }
    
    var title: some View{
        Text("SetOut!")
            .font(.title)
            .foregroundColor(.white)
    }
}

struct VFlashScreen_Previews: PreviewProvider {
    static var previews: some View {
        VFlashScreen()
    }
}
