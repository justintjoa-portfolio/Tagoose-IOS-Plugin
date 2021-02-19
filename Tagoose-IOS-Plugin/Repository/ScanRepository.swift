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
    
    func resolveVector (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
            return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
    }
    
    func renderer(target:SCNNode, _ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) -> (ARSCNView) -> ()  {
            // get camera translation and rotation
        
        return {
            sceneView in
                guard let pointOfView = sceneView.pointOfView else { return }
                let transform = pointOfView.transform // transformation matrix
                let orientation = SCNVector3(-transform.m31, -transform.m32, -transform.m33) // camera rotation
                let location = SCNVector3(transform.m41, transform.m42, transform.m43) // camera translation

            let currentPostionOfCamera = self.resolveVector(left: orientation, right: location)
    //          SCNTransaction.begin()
 
                target.position = currentPostionOfCamera
                
    //          SCNTransaction.commit()
        }
        
        
            
    }

 



    


}
