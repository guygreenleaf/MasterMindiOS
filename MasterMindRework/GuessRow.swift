//
//  GuessRow.swift
//  MasterMindRework
//
//  Created by Guy Greenleaf on 3/12/21.
//

import SwiftUI

struct GuessRow: View, Identifiable {
    let circleDiameter: CGFloat
    var colors: [Color]
    var id: Int
    var hasBeenGuessed = false
    @ObservedObject var viewModel : MasterMindViewModel


    
    var body: some View {

        ForEach((0..<viewModel.getGameBoard().count).reversed(), id: \.self){ ripl in
        HStack(spacing: 10.0) {
            
                ForEach( 0..<colors.count, id: \.self ) { idx in
                    GameCircle(diameter: circleDiameter, color:
                                convIntToColor(conv: viewModel.getCircleArray()[ripl][idx].color), id: viewModel.getCircleArray()[ripl][idx].id)
                        
                        .onTapGesture {
                            print(viewModel.getSelectedColor())
//                            viewModel.getCircleArray()[viewModel.getCurrCircleArrayNumber()][idx].color = viewModel.getSelectedColor()
//
                            viewModel.setCircleArrayColor( indx: idx)
                            print("--------------------------")
                            print(viewModel.getCircleArray()[viewModel.getCurrCircleArrayNumber()][idx])
                        }
                        
         
                }
                .animation(.easeIn(duration: 0.5))
            FeedbackArea(length: circleDiameter, viewModel: viewModel, id: ripl, currSpot: 0)
        }
        .animation(.easeIn(duration: 0.5))
    }
        .animation(.easeIn(duration:0.2))
    }
    
}


