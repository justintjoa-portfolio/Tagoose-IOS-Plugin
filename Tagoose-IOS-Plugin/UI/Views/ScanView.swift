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


class ScanView: UIView {
    
    var body: some View {
        ZStack {
            Scanner()
            ScanControls()
        }
    }
    
    
    


}
