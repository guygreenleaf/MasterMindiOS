//
//  GameCircle.swift
//  MasterMindRework
//
//  Created by Guy Greenleaf on 3/12/21.
//

import SwiftUI

struct GameCircle: View, Identifiable {
    let diameter: CGFloat
    let color: Color
    let id: Int
    
    var body: some View {
        return ZStack{
            Circle()
                .frame(width:diameter+5, height:diameter+5)
            Circle()
           
            .fill(color)
            .frame(width: diameter, height: diameter)
            
        }
       
    }

}

