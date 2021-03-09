//
//  ContentView.swift
//  MasterMindRework
//
//  Created by Guy Greenleaf on 3/7/21.
//

import SwiftUI

//var viewModel = MasterMindViewModel()

struct ContentView: View {
    

    var body: some View {
        GeometryReader{ geometry in
            body(geometry, viewModel: viewMode)
        }
            .padding()
    }
    
    var viewMode = SingletonVM.sharedInstance.globalViewModel
    
    func body(_ geometry: GeometryProxy, viewModel: MasterMindViewModel) -> some View{
        //palette colors to choose from
        let colorsPallette:[Color] = [.blue, .yellow, .purple, .red, .green]
        
        print(geometry.size)
        let paletteAreaWidth = geometry.size.width * 0.20            // 20% goes to palette
        let guessAreaWidth = geometry.size.width - paletteAreaWidth
        let numberOfGuessCircles = 4
        
        let largeCircleDiameter = guessAreaWidth / CGFloat(numberOfGuessCircles + 2) // one for the feedback and one for spaces in between
        

        
        return HStack(alignment: .bottom) {
            PaletteArea(colors: colorsPallette, circleDiameter: largeCircleDiameter, viewModel: viewModel)
                    .frame(width: paletteAreaWidth, height: geometry.size.height, alignment: .center)
                    .position(CGPoint(x: paletteAreaWidth / 4, y: geometry.size.height / 2.0))
                
                VStack {
                    

                    GuessArea(diameter: largeCircleDiameter, viewMode: viewModel)
                           

                    GuessRow(circleDiameter: largeCircleDiameter, colors: [.white, .white, .white, .white], id: viewModel.getCurrCircleArrayNumber(), viewModel: viewModel)
                        .frame(width: guessAreaWidth, height: 70, alignment: .bottom)
                    Text("Submit Guess")
                        .fontWeight(.bold)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .top, endPoint: .bottom))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .onTapGesture {
                            if(viewModel.tooManyRows() == 11){
                                print("LOSER!")
                            }
                            if(viewModel.checkForWin()){
                                print("WINNER!")
                            }
                            print(viewModel.getSelectedColor())
                            if(viewModel.checkIfFirstRow()){
                                viewModel.setInitialRowToColors()
//                                viewModel.addInitToGameBoard(gRow: GuessRow(circleDiameter: largeCircleDiameter, colors: [convIntToColor(conv: viewModel.getCircleArray()[0][0].color), convIntToColor(conv: viewModel.getCircleArray()[0][1].color), convIntToColor(conv: viewModel.getCircleArray()[0][2].color), convIntToColor(conv: viewModel.getCircleArray()[0][3].color)], id: viewModel.getAndIncreaseGuessRowID(), viewModel: viewModel))
                                
                            }
                            else{
                            viewModel.setRow()
                            }
                            viewModel.circlesPlus()
                            viewModel.increaseCurrCircleArrayNumber()
                            viewModel.newCircleLevel()
                            viewModel.newCircleIDForNewLevel()
//
                            viewModel.addInitToGameBoard(gRow: GuessRow(circleDiameter: largeCircleDiameter, colors: [Color.white, Color.white, Color.white, Color.white], id: viewModel.getAndIncreaseGuessRowID(), viewModel: viewModel))
                            viewModel.createNewGuessRow()
                            
                            print(viewModel.getCircleArray())
                            print(viewModel.getGameBoard())
                        }
    
                    Rectangle() // rectangles can serve as spacers.
                        .frame(width: guessAreaWidth, height: largeCircleDiameter, alignment: .bottom)
                        .opacity(0.0)
                        .padding()

    
            }
    
        }
    }
            

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}






// --------------------------------------------------
// GUESS AREA
struct GuessArea: View {
    let circleDiameter: CGFloat
    var guessLevels = [GuessRow]()
    @ObservedObject var viewModel:MasterMindViewModel
    
//    @ObservedObject var viewModel = MasterMindViewModel()
    init(diameter: CGFloat, viewMode: MasterMindViewModel) {
         viewModel = viewMode
        
        circleDiameter = diameter
        
//        viewModel.getGameBoard().append(GuessRow(circleDiameter: diameter, colors: [convIntToColor(conv: viewModel.getCircleArray()[0][0].color), convIntToColor(conv: viewModel.getCircleArray()[0][1].color), convIntToColor(conv: viewModel.getCircleArray()[0][2].color), convIntToColor(conv: viewModel.getCircleArray()[0][3].color)], id: viewModel.getAndIncreaseGuessRowID()))
//
        viewModel.addInitToGameBoard(gRow: GuessRow(circleDiameter: diameter, colors: [convIntToColor(conv: viewModel.getCircleArray()[0][0].color), convIntToColor(conv: viewModel.getCircleArray()[0][1].color), convIntToColor(conv: viewModel.getCircleArray()[0][2].color), convIntToColor(conv: viewModel.getCircleArray()[0][3].color)], id: viewModel.getAndIncreaseGuessRowID(), viewModel: viewModel))
    }
    
    
    var body: some View {
        VStack {
            Spacer()

            ForEach(viewModel.getGameBoard()) { row in
                VStack {
                    
                    
                }
            }
        }
    }
    
    func guessViewFor(level: Int) -> some View {
//        print("guessViewFor level \(level), size: \(size) ")
        return  guessLevels[level]
    }
    
    func fourBlankCircles() -> [Color] {
        return [Color.blue, Color.blue, Color.blue, Color.blue]
    }
}




struct GuessRow: View, Identifiable {
    let circleDiameter: CGFloat
    var colors: [Color]
    var id: Int
    @ObservedObject var viewModel : MasterMindViewModel

    
    
    
    var body: some View {
        ForEach(0..<viewModel.getGameBoard().count, id: \.self){ ripl in
        HStack(spacing: 20.0) {
            
                ForEach( 0..<colors.count, id: \.self ) { idx in
                    GameCircle(diameter: circleDiameter, color:
                                convIntToColor(conv: viewModel.getCircleArray()[ripl][idx].color), id: viewModel.getCircleArray()[ripl][idx].id)
                        .onTapGesture {
                            print(viewModel.getSelectedColor())
//                            viewModel.getCircleArray()[viewModel.getCurrCircleArrayNumber()][idx].color = viewModel.getSelectedColor()
//
                            viewModel.setCircleArrayColor( indx: idx)
                            print("HERE COMES JONNY!")
                            print(viewModel.getCircleArray()[viewModel.getCurrCircleArrayNumber()][idx])
                        }
                }
            
            
            FeedbackArea(length: circleDiameter)
        }
    }
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
            ForEach( 0..<colors.count ) { colorIdx in
                GameCircle(diameter: circleDiameter, color: colors[colorIdx], id: colorIdx)
                    .onTapGesture {
                        viewModel.userDidSelectColor(colorSelection: colorIdx+1)
                        print(viewModel.getSelectedColor())
                    }
            }
            //Show color selected
//            GameCircle(diameter: circleDiameter, color: colors[viewModel.getSelectedColor()], id: 9999)
//                .padding(.top, 275)
        }
    }
}



















struct FeedbackArea: View {
    let length: CGFloat
    
    var diameter: CGFloat {
        length / CGFloat(5.0)
    }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Circle()
                    .stroke(lineWidth: 1.0)
                    .frame(width: diameter, height: diameter, alignment: .leading)
                Circle()
                    .stroke(lineWidth: 1.0)
                    .frame(width: diameter, height: diameter, alignment: .trailing)
            }
            HStack {
                Circle()
                    .stroke(lineWidth: 1.0)
                    .frame(width: diameter, height: diameter, alignment: .leading)
                Circle()
                    .stroke(lineWidth: 1.0)
                    .frame(width: diameter, height: diameter, alignment: .trailing)

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
