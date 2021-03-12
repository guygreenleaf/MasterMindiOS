//
//  WinView.swift
//  MasterMindRework
//
//  Created by Guy Greenleaf on 3/11/21.
//

import SwiftUI



struct WinView: View, Identifiable {
    var viewMode = SingletonVM.sharedInstance.globalViewModel

    var id:Int = 1
    

    
    var body: some View {
        GeometryReader{ geometry in
            
            body(geometry)
        }
    
        .padding()
    
        .background(Image("bigMountain")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea())
            
   
    }
    
    func body(_ geometry: GeometryProxy ) -> some View{
        
        return
           VStack{
                
                Text("You win!")
            .font(.largeTitle)
                    .foregroundColor(.white)
                    .position(x: geometry.size.width/2 , y: geometry.size.height/2 )
                    
           
        Button("New Game"){
            viewMode.resetGame()
        }

            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .top, endPoint: .bottom))
            .foregroundColor(.white)
            .font(Font.footnote.weight(.heavy))

            .cornerRadius(10)
            
           
        
        }
    }
}

struct WinView_Previews: PreviewProvider {
    static var previews: some View {
        WinView()

                
       
    }
    
}
