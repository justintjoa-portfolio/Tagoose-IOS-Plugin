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
    
    var scanner:Scanner?
    
    init(scanner:Scanner) {
        self.scanner = scanner
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(scanner!.sceneView)

    }
    
    required init?(coder aDecoder: NSCoder)
        {
            super.init(coder: aDecoder)
        }
    



 

}
    
    



    
    



