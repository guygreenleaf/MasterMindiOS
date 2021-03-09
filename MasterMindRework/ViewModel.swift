//
//  ViewModel.swift
//  MasterMindRework
//
//  Created by Guy Greenleaf on 3/7/21.
//

import Foundation
class MasterMindViewModel: ObservableObject {
    @Published var masterMindModel = MasterMindModel()
    
    func getGameBoard()->Array<GuessRow>{
        return masterMindModel.guessRows
    }
    func addInitToGameBoard(gRow: GuessRow){
        masterMindModel.guessRows.append(gRow)
    }
    
    func setInitialRowToColors(){
        masterMindModel.guessRows[0].colors = [convIntToColor(conv: masterMindModel.circleArray[0][0].color), convIntToColor(conv: masterMindModel.circleArray[0][1].color), convIntToColor(conv: masterMindModel.circleArray[0][2].color),
            convIntToColor(conv:masterMindModel.circleArray[0][3].color)
        ]
        masterMindModel.guessRows[0].id = 0
    }
    
    func setRow(){
        masterMindModel.guessRows[masterMindModel.currCircleArray].colors = [convIntToColor(conv: masterMindModel.circleArray[masterMindModel.currCircleArray][0].color), convIntToColor(conv: masterMindModel.circleArray[masterMindModel.currCircleArray][1].color), convIntToColor(conv: masterMindModel.circleArray[masterMindModel.currCircleArray][2].color),
                                                                            convIntToColor(conv:masterMindModel.circleArray[masterMindModel.currCircleArray][3].color)
                                                                        ]
    }
    
    func getCircleArray()->Array<Array<Circles>>{
        return masterMindModel.circleArray
    }
    
    func getAndIncreaseGuessRowID()->Int{
        var currID = masterMindModel.guessRowID
        
        masterMindModel.guessRowID += 1
        
        return currID
    }
    
    func getAndIncreaseCircleID()->Int{
        let currID = masterMindModel.circleID
        
        masterMindModel.circleID += 1
        
        return currID
    }
    
    func getCircleID()->Int{
        
        masterMindModel.individCircID += 1
        return masterMindModel.individCircID
    }
    
    func newCircleIDForNewLevel(){
        masterMindModel.circleID += 6
    }
    func newCircleLevel(){
        let newCircles = [Circles(color: 0, id: masterMindModel.circleID+1), Circles(color:0, id: masterMindModel.circleID+2), Circles(color:0, id: masterMindModel.circleID+3), Circles(color:0, id: masterMindModel.circleID+4) ]
        //Append the row of circles to the Circle Array
        masterMindModel.circleArray.append(newCircles)
    }
    
    func getCurrCircleArrayNumber()->Int{
        
        return masterMindModel.currCircleArray
    }
    
    func checkIfFirstRow()->Bool{
        if(masterMindModel.currCircleArray == 0){
            return true
        }
        return false
    }
    func setCircleArrayColor( indx: Int){
        masterMindModel.circleArray[masterMindModel.currCircleArray][indx].color = masterMindModel.selectedColor
    }
    
    func increaseCurrCircleArrayNumber(){
        masterMindModel.currCircleArray += 1
    }
    
    func userDidSelectColor(colorSelection: Int){
        masterMindModel.selectedColor = colorSelection
    }
    
    func getSelectedColor()->Int{
        return masterMindModel.selectedColor
    }
    
    func checkForWin()->Bool{
        if(masterMindModel.circleArray[masterMindModel.currCircleArray][0].color == masterMindModel.solution[0] && masterMindModel.circleArray[masterMindModel.currCircleArray][1].color == masterMindModel.solution[1]) && masterMindModel.circleArray[masterMindModel.currCircleArray][2].color == masterMindModel.solution[2] &&
            masterMindModel.circleArray[masterMindModel.currCircleArray][3].color == masterMindModel.solution[3]{
            return true
        }
        return false
    }
    
    func createNewGuessRow(){
        
    }
    
    func circlesPlus(){
        masterMindModel.howManyCircles += 4
    }
    func getTheCircles()->Int{
        return masterMindModel.howManyCircles
    }
    
    func tooManyRows()->Int{
        return masterMindModel.guessRows.count
    }
}
