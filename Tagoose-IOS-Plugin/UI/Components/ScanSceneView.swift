//
//  ScanSceneView.swift
//  Tagoose-IOS-Plugin
//
//  Created by Hendrik Tjoa on 2/10/21.
//

import Foundation

import ARKit


class ScanSceneView: ARSCNView {
    var repository:ScanRepository;
    
    func doSomething(val configuration:ARWorldTrackingConfiguration) {
        session.run(configuration)
    }
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    init(repository:ScanRepository, frame:CGRect) {
        self.repository = repository;
        super.init(frame: frame)
        
    }
    

    
    
}

/*
 let configuration = ARObjectScanningConfiguration()
 configuration.planeDetection = .horizontal
 sceneView.session.run(configuration, options: .resetTracking)
*/
