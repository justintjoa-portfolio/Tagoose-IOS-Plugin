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
    
    init(scannedReferenceObject:ARReferenceObject, referenceObjectToMerge:ARReferenceObject) {
        self.scannedReferenceObject = scannedReferenceObject;
    }
    
    private var scannedReferenceObject:ARReferenceObject


    func completionHandler(referenceObject:ARReferenceObject?, mergeObject:ARReferenceObject?, transform: simd_float4x4, newName:String) -> ARReferenceObject? {
        return referenceObject.flatMap {
            (rObj) in
            return (processReferenceObj(referenceObject: rObj, transform: transform, newName: newName)).flatMap {
                (sObj) in
                return mergeObject.flatMap {
                    (mObj) in
                    return mergeObj(scannedObject: sObj, mergeObject: mObj)
                }
                
            }
            
        }
    
    }
    
    
    
    func processReferenceObj(referenceObject:ARReferenceObject, transform: simd_float4x4, newName:String) -> ARReferenceObject? {
        let result:ARReferenceObject = (referenceObject.applyingTransform(transform))
        result.name = newName
        self.scannedReferenceObject = result
        return result
    }
    
    func mergeObj(scannedObject:ARReferenceObject, mergeObject:ARReferenceObject) -> ARReferenceObject?  {
        do {
            try self.scannedReferenceObject = scannedObject.merging(mergeObject)
            return self.scannedReferenceObject
        }
        catch {
            self.scannedReferenceObject = mergeObject
            return nil
        }
        
    }
    



}
