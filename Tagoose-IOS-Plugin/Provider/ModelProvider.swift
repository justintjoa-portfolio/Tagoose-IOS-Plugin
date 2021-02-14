//
//  ModelProvider.swift
//  Tagoose-IOS-Plugin
//
//  Created by Hendrik Tjoa on 2/14/21.
//

import Foundation
import ARKit

class ModelProvider {
    func load3DModel(from url: URL) -> SCNNode? {
        guard let scene = try? SCNScene(url: url, options: nil) else {
            print("Error: Failed to load 3D model from file \(url)")
            return nil
        }
        
        let node = SCNNode()
        for child in scene.rootNode.childNodes {
            node.addChildNode(child)
        }
        
        // If there are no light sources in the model, add some
        let lightNodes = node.childNodes(passingTest: { node, _ in
            return node.light != nil
        })
        if lightNodes.isEmpty {
            let ambientLight = SCNLight()
            ambientLight.type = .ambient
            ambientLight.intensity = 100
            let ambientLightNode = SCNNode()
            ambientLightNode.light = ambientLight
            node.addChildNode(ambientLightNode)
            
            let directionalLight = SCNLight()
            directionalLight.type = .directional
            directionalLight.intensity = 500
            let directionalLightNode = SCNNode()
            directionalLightNode.light = directionalLight
            node.addChildNode(directionalLightNode)
        }
        
        return node
    }
    

}
