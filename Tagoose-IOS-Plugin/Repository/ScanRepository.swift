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
    

    static let objectCreationInterval: CFTimeInterval = 1.0
    
    
    
    // The object which we want to scan
    private(set) var scannedObject: ScannedObject
    
    // The result of this scan, an ARReferenceObject
    private(set) var scannedReferenceObject: ARReferenceObject?
    
    // The node for visualizing the point cloud.
    private(set) var pointCloud: ScannedPointCloud
    

    private var isBusyCreatingReferenceObject = false
    
    private(set) var screenshot = UIImage()
    
    private var hasWarnedAboutLowLight = false

    
    static let minFeatureCount = 100
    
    
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval,
                  center:CGPoint) {
        guard let frame = sceneView.session.currentFrame else { return }
        updateOnEveryFrame(frame, center:center)
        //testRun?.updateOnEveryFrame()
    }

    func updateOnEveryFrame(_ frame: ARFrame, center:CGPoint) -> Bool {

        if let points = frame.rawFeaturePoints {
            // Automatically adjust the size of the bounding box.
            self.scannedObject.fitOverPointCloud(points, center: center)
        }
        
        

            
            if let lightEstimate = frame.lightEstimate, lightEstimate.ambientIntensity < 500, !hasWarnedAboutLowLight{
                hasWarnedAboutLowLight = true
                return false;
            }
            
            // Try a preliminary creation of the reference object based off the current
            // bounding box & update the point cloud visualization based on that.
            if let boundingBox = scannedObject.eitherBoundingBox {
                // Note: Create a new preliminary reference object in regular intervals.
                //       Creating the reference object is asynchronous and likely
                //       takes some time to complete. Avoid calling it again before
                //       enough time has passed and while we still wait for the
                //       previous call to complete.
                let now = CACurrentMediaTime()
                if now - timeOfLastReferenceObjectCreation > ScanRepository.objectCreationInterval, !isBusyCreatingReferenceObject {
                    timeOfLastReferenceObjectCreation = now
                    isBusyCreatingReferenceObject = true
                    sceneView.session.createReferenceObject(transform: boundingBox.simdWorldTransform,
                                                            center: float3(),
                                                            extent: boundingBox.extent) { object, error in
                        if let referenceObject = object {
                            // Pass the feature points to the point cloud visualization.
                            self.pointCloud.update(with: referenceObject.rawFeaturePoints, localFor: boundingBox)
                        }
                        self.isBusyCreatingReferenceObject = false
                    }
                }
                
                // Update the point cloud with the current frame's points as well
                if let currentPoints = frame.rawFeaturePoints {
                    pointCloud.update(with: currentPoints)
                }
            }
        
        
        // Update bounding box side coloring to visualize scanning coverage

        scannedObject.boundingBox?.highlightCurrentTile()
        scannedObject.boundingBox?.updateCapturingProgress()
        
        
        scannedObject.updateOnEveryFrame(center: center)
        pointCloud.updateOnEveryFrame()
        return true;
    }
    
    var timeOfLastReferenceObjectCreation = CACurrentMediaTime()
    
    var qualityIsLow: Bool {
        return pointCloud.count < ScanRepository.minFeatureCount
    }
    
    var boundingBoxExists: Bool {
        return scannedObject.boundingBox != nil
    }
    
    var ghostBoundingBoxExists: Bool {
        return scannedObject.ghostBoundingBox != nil
    }
    
    var isReasonablySized: Bool {
        guard let boundingBox = scannedObject.boundingBox else {
            return false
        }
        
        // The bounding box should not be too small and not too large.
        // Note: 3D object detection is optimized for tabletop scenarios.
        let validSizeRange: ClosedRange<Float> = 0.01...5.0
        if validSizeRange.contains(boundingBox.extent.x) && validSizeRange.contains(boundingBox.extent.y) &&
            validSizeRange.contains(boundingBox.extent.z) {
            // Check that the volume of the bounding box is at least 500 cubic centimeters.
            let volume = boundingBox.extent.x * boundingBox.extent.y * boundingBox.extent.z
            return volume >= 0.0005
        }
        
        return false
    }
    
    /// - Tag: ExtractReferenceObject
    func createReferenceObject(completionHandler creationFinished: @escaping (ARReferenceObject?) -> Void) {
        guard let boundingBox = scannedObject.boundingBox, let origin = scannedObject.origin else {
            print("Error: No bounding box or object origin present.")
            creationFinished(nil)
            return
        }
        
        // Extract the reference object based on the position & orientation of the bounding box.
        sceneView.session.createReferenceObject(
            transform: boundingBox.simdWorldTransform,
            center: float3(), extent: boundingBox.extent,
            completionHandler: { object, error in
                if let referenceObject = object {
                    // Adjust the object's origin with the user-provided transform.
                    self.scannedReferenceObject = referenceObject.applyingTransform(origin.simdTransform)
                    self.scannedReferenceObject!.name = self.scannedObject.scanName
                } else {
                    print("Error: Failed to create reference object. \(error!.localizedDescription)")
                    creationFinished(nil)
                }
        })
    }
    
    private func createScreenshot() {
        guard let frame = self.sceneView.session.currentFrame else {
            print("Error: Failed to create a screenshot - no current ARFrame exists.")
            return
        }

        var orientation: UIImage.Orientation = .right
        switch UIDevice.current.orientation {
        case .portrait:
            orientation = .right
        case .portraitUpsideDown:
            orientation = .left
        case .landscapeLeft:
            orientation = .up
        case .landscapeRight:
            orientation = .down
        default:
            break
        }
        
        let ciImage = CIImage(cvPixelBuffer: frame.capturedImage)
        let context = CIContext()
        if let cgimage = context.createCGImage(ciImage, from: ciImage.extent) {
            screenshot = UIImage(cgImage: cgimage, scale: 1.0, orientation: orientation)
        }
    }
    
    
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
        let prev = currentNode.worldPosition
        currentNode.removeFromParentNode()
        currentNode.position = prev
        sceneView.scene.rootNode.addChildNode(currentNode)
        
        print(currentNode.worldPosition)
        print("HI")
    }
    
    func fixShape() {
        self.scannedObject.removeFromParentNode()
        self.pointCloud.removeFromParentNode()
        
        
        currentNode.removeFromParentNode()
        currentNode.position = SCNVector3Make(0, 0, -0.2)
        self.sceneView.pointOfView!.addChildNode(currentNode)
    }
    
  
    
    init(sceneView:ARSCNView) {
        self.sceneView = sceneView
        
        scannedObject = ScannedObject(sceneView)
        pointCloud = ScannedPointCloud()
        
        
        
        
        
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
        
        self.sceneView.scene.rootNode.addChildNode(self.scannedObject)
        self.sceneView.scene.rootNode.addChildNode(self.pointCloud)
        
    }
    
    


}
