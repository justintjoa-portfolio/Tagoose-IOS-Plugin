//
//  ScanEvent.swift
//  Tagoose-IOS-Plugin
//
//  Created by Hendrik Tjoa on 2/10/21.
//

import Foundation
import ARKit

class ScanEvent {
    
   
}




class updateFrame: ScanEvent {
    public var frame:ARFrame
    
    init(frame:ARFrame) {
        self.frame = frame
    }
}


class Tap:ScanEvent {
    
}

class LongPress:ScanEvent {
    
}

class Pinch:ScanEvent {
    
}


class Rotate:ScanEvent {
    
}

class twoFingerPan: ScanEvent {
    
}

class Scanning:ScanEvent {
    var frame:ARFrame
    init(frame:ARFrame) {
        self.frame = frame
    }
}

class oneFingerPan: ScanEvent {
    
}

class adjustingOrigin:ScanEvent {
    
}
