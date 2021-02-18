//
//  ScanController.swift
//  Tagoose-IOS-Plugin
//
//  Created by Hendrik Tjoa on 2/10/21.
//

import ARKit

import Foundation
import RxSwift
import RxCocoa


class ScanController: UIViewController {
    
    var sceneView: ARSCNView?
    
    init(sceneView:ARSCNView) {
        self.sceneView = sceneView
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(sceneView!)
        let config = ARObjectScanningConfiguration()
        sceneView?.session.run(config, options: .resetTracking)

    }
    
    required init?(coder aDecoder: NSCoder)
        {
            super.init(coder: aDecoder)
        }
    



 

}
    
    



    
    



