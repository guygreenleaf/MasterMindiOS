//
//  FeedbackArea.swift
//  MasterMindRework
//
//  Created by Guy Greenleaf on 3/12/21.
//

import SwiftUI


struct FeedbackArea: View, Identifiable {
    let length: CGFloat
    @ObservedObject var viewModel: MasterMindViewModel
    let id : Int
    var possibleColors:Array<Color> = [.white, .red, .blue, .white]
    var diameter: CGFloat {
        length / CGFloat(5.0)
    }
    let currSpot: Int
    
    var big = 12
    var body: some View {
        if(viewModel.getCurrCircleArrayNumber() != 0 && viewModel.getGameBoard()[id].hasBeenGuessed){
        VStack(alignment: .leading) {
            if(viewModel.getCircleArray()[id][0].color == viewModel.getSolution()[0] && viewModel.getCircleArray()[id][1].color == viewModel.getSolution()[1] && viewModel.getCircleArray()[id][2].color == viewModel.getSolution()[2] && viewModel.getCircleArray()[id][3].color == viewModel.getSolution()[3]){
                Text("You Win!")
                    .background(Rectangle().frame(width:300, height:350).foregroundColor(Color.white).ignoresSafeArea().padding(.leading, 80).padding(.top, 20).opacity(0) )
                    .font(.largeTitle)
                    
                    .ignoresSafeArea()
                    .frame(width:510, height:20)
                    .ignoresSafeArea()
                    .padding(.trailing, 400)
//                    .padding(.top, 600)
            }
            
            
            if(viewModel.tooManyRows() > 6){
               
                Text("You Lose..Try Again!")
                    .background(Rectangle().frame(width:1200, height:1200).foregroundColor(Color.white).ignoresSafeArea().padding(.top, 900))
                    .font(.largeTitle)
                    
                    .ignoresSafeArea()
                    .frame(width:510, height:1200)
                    .ignoresSafeArea()
                    .padding(.trailing, 400)
                    .padding(.top, 600)
                
                SolutionRow(circleDiameter: diameter, viewModel: viewModel)
            }
            
            HStack {
                //Change what circle is filled with
                if(viewModel.getCircleArray()[id][0].color == viewModel.getSolution()[0]){
                Circle()
                    .fill(Color.green)
                .frame(width: diameter, height: diameter)
                }
                else if(viewModel.getSolution().contains(viewModel.getCircleArray()[id][0].color)){
                
                Circle()
                    .fill(Color.red)
                .frame(width: diameter, height: diameter)
                }
                
                else{
                    Circle()
                        .fill(Color.white)
                     
                        .frame(width: diameter, height: diameter)
                }
                
                
                
                if(viewModel.getCircleArray()[id][1].color == viewModel.getSolution()[1]){
                Circle()
                    .fill(Color.green)
                .frame(width: diameter, height: diameter)
                }
                else if(viewModel.getSolution().contains(viewModel.getCircleArray()[id][1].color)){
                
                Circle()
                    .fill(Color.red)
                .frame(width: diameter, height: diameter)
                }
                
                else{
                    Circle()
                        .fill(Color.white)
                        .frame(width: diameter, height: diameter)
                }
                }
            HStack {
                
                
                if(viewModel.getCircleArray()[id][2].color == viewModel.getSolution()[2]){
                Circle()
                    .fill(Color.green)
                .frame(width: diameter, height: diameter)
                }
                else if(viewModel.getSolution().contains(viewModel.getCircleArray()[id][2].color)){
                
                Circle()
                    .fill(Color.red)
                .frame(width: diameter, height: diameter)
                }
                
                else{
                    Circle()
                        .fill(Color.white)
                        .frame(width: diameter, height: diameter)
                }
                
                
                
                if(viewModel.getCircleArray()[id][3].color == viewModel.getSolution()[3]){
                Circle()
                    .fill(Color.green)
                .frame(width: diameter, height: diameter)
                }
                else if(viewModel.getSolution().contains(viewModel.getCircleArray()[id][3].color)){
                
                Circle()
                    .fill(Color.red)
                .frame(width: diameter, height: diameter)
                }
                
                else{
                    Circle()
                        .fill(Color.white)
                        .frame(width: diameter, height: diameter)
                }
                
                
                

                
                }
            }
        }
        else{  VStack(alignment: .leading){
            
            HStack {
                Circle()
                .opacity(0)
          
                .frame(width: diameter, height: diameter)
                Circle()
                .opacity(0)
                .frame(width: diameter, height: diameter)
                
                }
            HStack {
                Circle()
                .opacity(0)
                .frame(width: diameter, height: diameter)
                Circle()
                .opacity(0)
                .frame(width: diameter, height: diameter)
                
                }
        }
        }
    }
}


