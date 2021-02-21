//
//  ScanView.swift
//  Tagoose-IOS-Plugin
//
//  Created by Hendrik Tjoa on 2/10/21.
//

import Foundation
import SwiftUI
import ARKit
import RealityKit
import RxSwift

final class ScanView: View {
    
    var update: ((ScanEvent) -> (Observable<ScanState>))?
    
    var body: some View {
        ZStack {
            Scanner(update: update!)
            ScanControls(update: update!)
        }
    }
    
    init(update: @escaping  (ScanEvent) -> (Observable<ScanState>)) {
        //super.init(frame: UIScreen.main.bounds)
        self.update = update
        //self.addSubview(body as! UIView)
    }
    
    /*
    required init?(coder aDecoder: NSCoder)
        {
            super.init(coder: aDecoder)
        }
    
    */
    


}
