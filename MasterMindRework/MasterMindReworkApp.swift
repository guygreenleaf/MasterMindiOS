//
//  MasterMindReworkApp.swift
//  MasterMindRework
//
//  Created by Guy Greenleaf on 3/7/21.
//

import SwiftUI

@main
struct MasterMindReworkApp: App {
    @ObservedObject var vModel = SingletonVM.sharedInstance.globalViewModel
    var body: some Scene {
        WindowGroup {
            
            if(!vModel.getGameStarted()){
                MenuView()
                    .transition(.slide)
                    .animation(.spring())
            }
            
            else if(vModel.getButtonCheck() && vModel.getGameStarted()){
            ContentView()
                .transition(.slide)
                .animation(.spring())
            }
            else{
                WinView()
                    .transition(.slide)
                    .animation(.spring())
                    .background(Image("bigMountain")           .resizable()
                                    .scaledToFill()
                                    .ignoresSafeArea())
                         
            }
    
        }


    }



}



