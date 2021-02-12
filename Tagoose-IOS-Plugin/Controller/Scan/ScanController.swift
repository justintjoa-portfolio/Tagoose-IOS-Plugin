//
//  ScanController.swift
//  Tagoose-IOS-Plugin
//
//  Created by Hendrik Tjoa on 2/10/21.
//

import ARKit

import Foundation


class ScanController {
    
    var _repository:ScanRepository
    
    init(repository:ScanRepository) {
        self._repository = repository
    }


    
    
    
    func createReferenceObject(session:ARSession, referenceObject:ARReferenceObject?, mergeObject:ARReferenceObject?, transform: simd_float4x4, center: simd_float3, extent: simd_float3, newName:String) {
        session.createReferenceObject(
            transform: transform,
            center: center,
            extent: extent,
            completionHandler: { object, error in
                self._repository.completionHandler(referenceObject: referenceObject, mergeObject: mergeObject, transform: transform, newName: newName)
            })
    }
    
    
}


