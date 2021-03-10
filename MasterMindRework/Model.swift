//
//  Model.swift
//  MasterMindRework
//
//  Created by Guy Greenleaf on 3/7/21.
//

import Foundation

struct MasterMindModel{
  

    
    var guessRows = [GuessRow]()
    //Represent color as int
    var currentlySelectedColor = 0
    
    //Array of Array of circles for representing guess row
    var circleArray:Array<Array<Circles>> = []
    
    var currCircleArray = 0
    //circleID to make each circle unique
    var circleID = 0
    //Identify each guess row
    var guessRowID = 0
    //Represents the color the user selects from the palette. Is set whenever the user taps on a color from the palette. Defaults/starts at 0 to represent a blank choice
    var selectedColor = 0
    
    var individCircID = 0
    var howManyCircles = 0
    
    
    
    var userDidGuess = false
    init(){
        //Initialize a row of circles that are Blank.  The color:0 means its a white circle. Give each one a unique id.
        let startCircles = [Circles(color: 0, id: circleID+1), Circles(color:0, id: circleID+2), Circles(color:0, id: circleID+3), Circles(color:0, id: circleID+4) ]
        //Append the row of circles to the Circle Array
        circleArray.append(startCircles)
        howManyCircles += 4 
        
    
    }
    
    
    var solution = [2, 3, 1, 2]
}





struct Circles:Identifiable{
    var color:Int
    var id: Int
}
