//
//  ScanController.swift
//  Tagoose-IOS-Plugin
//
//  Created by Hendrik Tjoa on 2/10/21.
//
//used for reference: https://stackoverflow.com/questions/60823803/how-to-add-a-cube-in-the-center-of-the-screen-and-so-that-it-never-leaves

import ARKit

import Foundation
import RxSwift
import RxCocoa


class ScanController: UIViewController {
    
    var _repository:ScanRepository?
    
    var _view:ScanView?
    
    init(_view:ScanView, _repository:ScanRepository) {
        self._view = _view
        self._repository = _repository
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(_view!)

    }
    

    
    required init?(coder aDecoder: NSCoder)
        {
            super.init(coder: aDecoder)
        }
    



 

}
    
    



    
    



