//
//  ScanState.swift
//  Tagoose-IOS-Plugin
//
//  Created by Hendrik Tjoa on 2/10/21.
//

import Foundation


class ScanState {
    
}

class Success: ScanState {
    
}

class Failure: ScanState {
    var message: String
    
    init(message:String) {
        self.message = message
    }
}



