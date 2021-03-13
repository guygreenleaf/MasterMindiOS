//
//  SolutionView.swift
//  MasterMindRework
//
//  Created by Guy Greenleaf on 3/12/21.
//

import SwiftUI


struct SolutionRow: View {
   
    let circleDiameter: CGFloat
    
    @ObservedObject var viewModel : MasterMindViewModel

    
    var body: some View {
        if(viewModel.isSolutionShowing()){
        HStack{
            GameCircle(diameter: circleDiameter, color: convIntToColor(conv: viewModel.getSolution()[0]) , id: 500)
                .padding(.bottom, 120)
            GameCircle(diameter: circleDiameter, color: convIntToColor(conv: viewModel.getSolution()[1]) , id: 501)
                .padding(.bottom, 120)
            GameCircle(diameter: circleDiameter, color: convIntToColor(conv: viewModel.getSolution()[2]) , id: 502)
                .padding(.bottom, 120)
            GameCircle(diameter: circleDiameter, color: convIntToColor(conv: viewModel.getSolution()[3]) , id: 503)
                .padding(.bottom, 120)
        }
       
      
        
        
        }
        if(viewModel.tooManyRows() > 6){
 
        HStack{
            GameCircle(diameter: circleDiameter, color: convIntToColor(conv: viewModel.getSolution()[0]) , id: 500)
               
            GameCircle(diameter: circleDiameter, color: convIntToColor(conv: viewModel.getSolution()[1]) , id: 501)
                
            GameCircle(diameter: circleDiameter, color: convIntToColor(conv: viewModel.getSolution()[2]) , id: 502)
                
            GameCircle(diameter: circleDiameter, color: convIntToColor(conv: viewModel.getSolution()[3]) , id: 503)
               
        }
        .padding(.leading, 250)
       
    }
    }
}



