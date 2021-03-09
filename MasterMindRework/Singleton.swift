//
//  Singleton.swift
//  MasterMindRework
//
//  Created by Guy Greenleaf on 3/8/21.
//

import Foundation
class SingletonVM: ObservableObject{
    static let sharedInstance = SingletonVM()
    init(){}
    
     var globalViewModel = MasterMindViewModel()
}
