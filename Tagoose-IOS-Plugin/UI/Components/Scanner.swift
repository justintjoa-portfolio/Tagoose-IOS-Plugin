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


struct Scanner: UIViewRepresentable {

    
    
    func makeUIView(context: Context) -> UIView {
        var result:ARSCNView?
        self.update(RequestARSCNView()).subscribe(
            onNext: { state in
                let viewState = state as! ViewStartState
                result = viewState.view
                
            }
        )
        var newView = UIView(frame: UIScreen.main.bounds)
        newView.addSubview(result!)
        return newView
    }
    
    
    var update: (ScanEvent) -> Observable<ScanState>
    

    
    init(update: @escaping ((ScanEvent) -> (Observable<ScanState>))) {
        self.update = update
    }
    
    
    
    func updateUIView(_ uiView: UIView, context: Context) {
        print("no need to update!")
    }

    typealias UIViewType = UIView
    
    



    
}






