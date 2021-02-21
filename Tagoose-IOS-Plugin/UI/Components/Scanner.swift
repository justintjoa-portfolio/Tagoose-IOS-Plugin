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


final class Scanner: UIViewRepresentable {
    func makeUIView(context: Context) -> ARSCNView {
        var result:ARSCNView?
        self.update(RequestARSCNView()).subscribe(
            onNext: { state in
                let viewState = state as! ViewStartState
                result = viewState.view
                
            }
        )
        return result!
    }
    
    
    var update: (ScanEvent) -> Observable<ScanState>
    

    
    init(update: @escaping ((ScanEvent) -> (Observable<ScanState>))) {
        self.update = update
    }
    
    
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {
        print("no need to update!")
    }

    typealias UIViewType = ARSCNView
    
    



    
}






