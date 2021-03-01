//
//  ScanState.swift
//  Tagoose-IOS-Plugin
//
//  Created by Hendrik Tjoa on 2/10/21.
//

import Foundation
import ARKit

protocol ScanState {
    
}

class ViewStartState: ScanState {
    var view:ARSCNView
    
    init(view:ARSCNView) {
        self.view = view
    }
    
}

class MessageState: ScanState {
    var message:String
    
    init(message:String) {
        self.message = message
    }
}

class ErrorState: MessageState {

}

class ToggleCubeState: MessageState {
    
}

