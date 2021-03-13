//
//  ContentView.swift
//  MasterMindRework
//
//  Created by Guy Greenleaf on 3/7/21.
//

import SwiftUI

struct ContentView: View {
     var viewMode = SingletonVM.sharedInstance.globalViewModel
    @State var isClicked = false
    
    func checkForOpacity()->Double{
        if(isClicked){
            return 0.0
        }
        return 100.0
    }
    
    var body: some View {
        GeometryReader{ geometry in
      
            body(geometry, viewModel: viewMode)
                
        }
        .padding()
    
        .background(Image("bigMountain")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea())

    }
    

    func startGame(diameter: CGFloat) {
        
        viewMode.addInitToGameBoard(gRow: GuessRow(circleDiameter: diameter, colors: [convIntToColor(conv: viewMode.getCircleArray()[0][0].color), convIntToColor(conv: viewMode.getCircleArray()[0][1].color), convIntToColor(conv: viewMode.getCircleArray()[0][2].color), convIntToColor(conv: viewMode.getCircleArray()[0][3].color)], id: viewMode.getAndIncreaseGuessRowID(), viewModel: viewMode))
    }
    
    func body(_ geometry: GeometryProxy,  viewModel: MasterMindViewModel ) -> some View{
        //palette colors to choose from
        let colorsPallette:[Color] = [.blue, .yellow, .purple, .red, .green]
        
//        print(geometry.size)
        let paletteAreaWidth = geometry.size.width * 0.20            // 20% goes to palette
        let guessAreaWidth = geometry.size.width - paletteAreaWidth
        let numberOfGuessCircles = 4
        let whiteCellArray:Array<Color> = [.white, .white, .white, .white]
        let largeCircleDiameter = guessAreaWidth / CGFloat(numberOfGuessCircles + 2) // one for the feedback and one for spaces in between
        
        startGame(diameter: largeCircleDiameter)

        return
            HStack(alignment: .bottom) {
 
            PaletteArea(colors: colorsPallette, circleDiameter: largeCircleDiameter, viewModel: viewModel)
                    .frame(width: paletteAreaWidth, height: geometry.size.height, alignment: .center)
                    .position(CGPoint(x: paletteAreaWidth / 4, y: geometry.size.height / 2.0))
                
                VStack {
                    SolutionRow( circleDiameter: largeCircleDiameter, viewModel: viewMode)
                    GuessRow(circleDiameter: largeCircleDiameter, colors: whiteCellArray, id: viewModel.getCurrCircleArrayNumber(), viewModel: viewModel)
                        .frame(width: guessAreaWidth, height: 50, alignment: .bottom)
                    
                    if(viewMode.tooManyRows() < 6){
                    HStack{
                        
                        
                        Button("Reset"){
                            viewModel.resetGame()
                            startGame(diameter: largeCircleDiameter)
                            viewModel.setGameNotStarted()
                        }
                        
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .top, endPoint: .bottom))
                        .foregroundColor(.white)
                        .font(Font.footnote.weight(.heavy))
                        
                        .cornerRadius(10)
                        .frame(width: 100, alignment:.bottom)
                        .padding(.trailing, 35)
                  
                        Button("Submit Guess"){
            
                            if(viewModel.tooManyRows() < 11 && viewModel.getButtonCheck()){
                            viewModel.userGuessed(indx: viewModel.getCurrCircleArrayNumber())
                            viewModel.userGuess()
         
                            
//                            print(viewModel.userSubmitted())
//                            print(viewModel.getSelectedColor())
                                
                            if(viewModel.checkIfFirstRow()){
                                viewModel.setInitialRowToColors()
                                
                            }
                            else{
                            viewModel.setRow()
                            }

                                if(viewModel.checkForWin()){
                                viewModel.removeLastCircle()
                                viewModel.removeLastGameBoardRow()
                                   viewModel.forButtonCheck()
                                   
                                }
                            viewModel.circlesPlus()
                                
                            viewModel.increaseCurrCircleArrayNumber()
                            viewModel.newCircleLevel()
                            viewModel.newCircleIDForNewLevel()
//
                            viewModel.addInitToGameBoard(gRow: GuessRow(circleDiameter: largeCircleDiameter, colors: [Color.white, Color.white, Color.white, Color.white], id: viewModel.getAndIncreaseGuessRowID(), viewModel: viewModel))

//                            print(viewModel.getCircleArray())
//                            print(viewModel.getGameBoard())
                            
                            
                            }
                            
                        }
                   
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .top, endPoint: .bottom))
                        .foregroundColor(.white)
                        .font(Font.footnote.weight(.heavy))
                        
                        .cornerRadius(10)
                        .frame(width: 100, alignment:.bottom)
                        .padding(.trailing, 35)
                        
                     
                        Button("Show Solution"){
                            if(viewModel.tooManyRows() < 7 && !(viewModel.returnWin())){
                                viewMode.showSolution()
                            }

                        }
                        
                        
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .top, endPoint: .bottom))
                        .foregroundColor(.white)
                        .font(Font.footnote.weight(.heavy))
                        
                        .cornerRadius(10)
                        .frame(width: 100, alignment:.bottom)
                        .onTapGesture {
                            
                        }
                        .padding(.trailing, 90)
                    }
                }
            }
        }
    }
            

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}


//Used to convert integers to colors
func convIntToColor(conv: Int)-> Color{
    switch conv {
    case 0:
        return Color.white
    case 1:
        return Color.blue
    case 2:
        return Color.yellow
    case 3:
        return Color.purple
    case 4:
        return Color.red
    case 5:
        return Color.green
    default:
        return Color.white
    }
}
