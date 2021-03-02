//
//  ScanRepository.swift
//  Tagoose-IOS-Plugin
//
//  Created by Hendrik Tjoa on 2/10/21.
//

import Foundation

import ARKit
import SceneKit

class ScanRepository {
    
    enum State {
        case Scanning
        case Searching
    }
    
    var currentNode: SCNNode
    
    
    var currentState = State.Searching
    
    func toggleState() -> String {
        switch currentState {
            case State.Scanning:
                fixShape()
                currentState = State.Searching
            case State.Searching:
                freeShape()
                currentState = State.Scanning
        }
        if (currentState == State.Scanning) {
            return "Cancel"
        }
        else {
            return "Scan"
        }
    }
    

    var sceneView:ARSCNView
    
    func freeShape() {
        currentNode.removeFromParentNode()
        print(sceneView.pointOfView!.position)
        currentNode.position = plus(a: SCNVector3Make(0, 0, -0.2), b: sceneView.pointOfView!.position)
        sceneView.scene.rootNode.addChildNode(currentNode)
        
        
        /*
        print(sceneView.scene.rootNode.position)
        print(sceneView.scene.rootNode.worldPosition)
        print(sceneView.pointOfView!.position)
        print(sceneView.pointOfView!.worldPosition)
 */
    }
    
    func fixShape() {
        currentNode.removeFromParentNode()
        currentNode.position = SCNVector3Make(0, 0, -0.2)
        self.sceneView.pointOfView!.addChildNode(currentNode)
    }
    
  
    
    init(sceneView:ARSCNView) {
        self.sceneView = sceneView
        
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
        
        shape.name = "Box"
        
        self.currentNode = shape
        
        
        let config = ARObjectScanningConfiguration()
        self.sceneView.session.run(config, options: .resetTracking)
        self.sceneView.pointOfView!.addChildNode(currentNode)
    }
    
    


}
