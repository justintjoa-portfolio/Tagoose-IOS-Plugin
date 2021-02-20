//
//  Scanner.swift
//  Tagoose-IOS-Plugin
//
//  Created by Hendrik Tjoa on 2/18/21.
//

import Foundation

import ARKit


class Scanner {
    
    var sceneView:ARSCNView
    
    init(sceneView:ARSCNView) {
        self.sceneView = sceneView
        let config = ARObjectScanningConfiguration()
        sceneView.session.run(config, options: .resetTracking)
        
        let sm = "float u = _surface.diffuseTexcoord.x; \n" +
            "float v = _surface.diffuseTexcoord.y; \n" +
            "int u100 = int(u * 100); \n" +
            "int v100 = int(v * 100); \n" +
            "if (u100 % 99 == 0 || v100 % 99 == 0) { \n" +
            "  // do nothing \n" +
            "} else { \n" +
            "    discard_fragment(); \n" +
            "} \n"
        
        let box = SCNBox(width: 0.05, height: 0.05, length: 0.05, chamferRadius: 0)

        box.firstMaterial?.emission.contents = UIColor.green

        box.firstMaterial?.shaderModifiers = [SCNShaderModifierEntryPoint.surface: sm]

        box.firstMaterial?.isDoubleSided = true
        
        let shape = SCNNode(geometry: box)
        
        shape.position = SCNVector3Make(0, 0, -0.2)
        
        self.sceneView.pointOfView!.addChildNode(shape)
        
        //sceneView.scene.rootNode.addChildNode(SCNNode(geometry: box))
    }
    



    

    
    
}

