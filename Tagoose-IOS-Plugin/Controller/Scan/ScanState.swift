//
//  ScanState.swift
//  Tagoose-IOS-Plugin
//
//  Created by Hendrik Tjoa on 2/10/21.
//

import Foundation


class ScanState {
    
}

class SuccessfulScan: ScanState {
    
}

class FailedScan: ScanState {
    var errorMessage:String
    
    init(errorMessage:String) {
        self.errorMessage = errorMessage
    }
}

