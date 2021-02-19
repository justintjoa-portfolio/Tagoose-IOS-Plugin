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
    
    
    
    
    var scanner:Scanner?
    
    var _repository:ScanRepository?
    
    init(scanner:Scanner, _repository:ScanRepository) {
        self.scanner = scanner
        self._repository = _repository
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(scanner!.sceneView)

    }
    
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval, target:SCNNode) {
        _repository?.renderer(target: target, renderer, willRenderScene: scene, atTime: time)(scanner!.sceneView)
        }
    
    required init?(coder aDecoder: NSCoder)
        {
            super.init(coder: aDecoder)
        }
    



 

}
    
    



    
    



