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
                
//
//            Text("welcome!")
//                .opacity(checkForOpacity())
//                .font(.largeTitle)
//                .onTapGesture {
//                    isClicked.toggle()
//
//                }
//
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
        
        print(geometry.size)
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
         
                            
                 
                            print(viewModel.userSubmitted())
//                            if(viewModel.tooManyRows() > 10){
//                                viewModel.eraseGameBoard()
//
//                            }

                            print(viewModel.getSelectedColor())
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

                            print(viewModel.getCircleArray())
                            print(viewModel.getGameBoard())
                            
                            
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
//                    Rectangle() // rectangles can serve as spacers.
//                        .frame(width: guessAreaWidth, height: largeCircleDiameter, alignment: .bottom)
//                        .opacity(0.0)
//                        .padding()

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




//NEED 3 POSSIBLE CIRCLES, BLANK, RED, OR GREEN
//NEED IF CHECK TO CHECK THESE [IMPLEMENT IN VIEWMODEL TO RETURN INT TO TURN INTO COLOR WITH CONV]:
//  FUNC someFunc() -> Int {
//    #Create var colorOfFeedback:Int = 0
//  IS COLOR EVEN IN THE ARRAY?
//     NO -> RETURN BLANK(0)
//     YES -> GO STEP 2
// IS COLOR AT PROPER INDEX?
//     NO -> RETURN RED(4)
//     YES -> RETURN GREEN(5)
// }

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
