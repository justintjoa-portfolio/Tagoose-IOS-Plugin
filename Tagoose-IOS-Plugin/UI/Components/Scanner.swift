//
//  Scanner.swift
//  Tagoose-IOS-Plugin
//
//  Created by Hendrik Tjoa on 2/18/21.
//

import Foundation

import ARKit
import UIKit
import SwiftUI
import RxSwift


class Scanner: UIViewRepresentable {
    
    var update: ((ScanEvent) -> (Observable<ScanState>))?
    

    
    init(update: @escaping ((ScanEvent) -> (Observable<ScanState>))) {
        self.update = update
    }
    
    
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {
        update(requestARSCNView).subscribe(
            onNext: { state in
                
                
            }
        )
    }
    
    func makeUIView(context: Context) -> ARSCNView {
        
    }
    
  
    
    typealias UIViewType = ARSCNView
    
    



    
}






