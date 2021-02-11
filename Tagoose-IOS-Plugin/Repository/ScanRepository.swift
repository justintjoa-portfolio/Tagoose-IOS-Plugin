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
    


    func processReferenceObj(referenceObject:ARReferenceObject, transform: simd_float4x4, newName:String) -> ARReferenceObject? {
        let result:ARReferenceObject = (referenceObject.applyingTransform(transform))
        result.name = newName
        return result
    }
    
    func mergeObj(scannedObject:ARReferenceObject, mergeObject:ARReferenceObject) -> ARReferenceObject?  {
        do {
            return try scannedObject.merging(mergeObject)
        }
        catch {
            return nil
        }
        
    }
    
    
    func completionHandler(refObject:ARReferenceObject?, mergeObject:ARReferenceObject?, transform: simd_float4x4, newName:String) -> ARReferenceObject? {
        var result:ARReferenceObject?;
        if let referenceObject = refObject {
                    // Adjust the object's origin with the user-provided transform.
            if let sObj = processReferenceObj(referenceObject: referenceObject, transform: transform, newName: newName) {
                if let mObj = mergeObject {
                    // Try to merge the object which was just scanned with the existing one.
                    result = mergeObj(scannedObject: sObj, mergeObject: mObj)
                }
            }
                    
        }
        return result
    }


}
