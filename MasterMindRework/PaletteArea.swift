//
//  PaletteArea.swift
//  MasterMindRework
//
//  Created by Guy Greenleaf on 3/12/21.
//

import SwiftUI



struct PaletteArea: View {
    @State private var offset: CGSize = .zero
    
//    @ObservedObject var viewModel = MasterMindViewModel()
    let colors: [Color]
    let circleDiameter: CGFloat
    @ObservedObject var viewModel: MasterMindViewModel

    var body: some View {
                
        return VStack(alignment: .leading, spacing: 10) {
            HStack{
     
            GameCircle(diameter: circleDiameter, color: convIntToColor(conv: viewModel.getSelectedColor()) , id: 9999)
                .padding(.bottom, 120)
   
   
            }

            ForEach( 0..<colors.count ) { colorIdx in
                GameCircle(diameter: circleDiameter, color: colors[colorIdx], id: colorIdx)
                    .onTapGesture {
                        viewModel.userDidSelectColor(colorSelection: colorIdx+1)
                        print(viewModel.getSelectedColor())
                    }
            }

            Rectangle()
                        .frame(width: 1, height: 250, alignment: .bottom)
                        .opacity(0.0)
                        .padding()            //Show color selected
//            GameCircle(diameter: circleDiameter, color: colors[viewModel.getSelectedColor()], id: 9999)
//                .padding(.top, 275)
        }
    }
}


