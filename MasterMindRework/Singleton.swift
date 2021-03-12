//
//  Singleton.swift
//  MasterMindRework
//
//  Created by Guy Greenleaf on 3/8/21.
//

import Foundation
class SingletonVM: ObservableObject{
    
    static var sharedInstance = SingletonVM()
    
    init(){}
    
    @Published var globalViewModel = MasterMindViewModel()
    
    static var shareReset:SingletonVM {
       return self.sharedInstance 
    }
}

