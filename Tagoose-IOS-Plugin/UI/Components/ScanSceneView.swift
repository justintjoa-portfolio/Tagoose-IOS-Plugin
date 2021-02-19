//
//  ScanSceneView.swift
//  Tagoose-IOS-Plugin
//
//  Created by Hendrik Tjoa on 2/10/21.
//
import Foundation

import ARKit


class Scanner {
    
    var sceneView:ARSCNView
    
    init(sceneView:ARSCNView) {
        self.sceneView = sceneView
        let config = ARObjectScanningConfiguration()
        sceneView.session.run(config, options: .resetTracking)
        
        let box:SCNNode = SCNNode(geometry: SCNBox(width: CGFloat(0.1), height: CGFloat(0.1), length: CGFloat(0.1), chamferRadius: CGFloat(0)))
        box.geometry?.firstMaterial?.fillMode = .lines
        box.geometry?.firstMaterial?.diffuse.contents = UIColor.green
        sceneView.scene.rootNode.addChildNode(box)
    }
    



    

    
    
}


