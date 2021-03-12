//
//  MenuView.swift
//  MasterMindRework
//
//  Created by Guy Greenleaf on 3/11/21.
//

import SwiftUI

struct MenuView: View {
    var viewMode = SingletonVM.sharedInstance.globalViewModel

    var id:Int = 1
    

    
    var body: some View {
        GeometryReader{ geometry in
            
            body(geometry)
        }
    
        .padding()
    
        .background(Color.black
                        .scaledToFill()
                        .ignoresSafeArea())

   
    }
    
    func body(_ geometry: GeometryProxy ) -> some View{
        
        return
           VStack{
                
                Text("MasterMind")
            .font(.largeTitle)
                    .foregroundColor(.white)
                    .position(x: geometry.size.width/2 , y: geometry.size.height/2 - 150 )
                    
           Text("Click on the color palette to the left of the screen to choose a color.  The corresponding color selection will appear on the top left of the screen.  ")
            .font(.headline)
            .foregroundColor(.white)
            .padding(.bottom, 10)
            
            
            
            
   Text("Then, select a circle in the guess row that starts near the bottom of the screen to change the appropriate circle to the color chosen.  Try to match all circles with the color solution.   ")
    .font(.headline)
    .foregroundColor(.white)
    .padding(.bottom, 10)
    
            Text("The feedback area will show you a color of green if the color is in the correct spot, red if the color is in the solution but not in the correct spot in your guess, or white if the color is not in the solution set.  The feedback circles are ordered from top left to bottom right corresponding to the guess row from left to right, respectively. ")
             .font(.headline)
             .foregroundColor(.white)
             .padding(.bottom, 10)
            

        Button("New Game"){
            
            viewMode.setGameStarted()
        }

            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .top, endPoint: .bottom))
            .foregroundColor(.white)
            .font(Font.footnote.weight(.heavy))

            .cornerRadius(10)
            
           
        
        }
    }
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
