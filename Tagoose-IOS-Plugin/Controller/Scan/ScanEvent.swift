//
//  ScanEvent.swift
//  Tagoose-IOS-Plugin
//
//  Created by Hendrik Tjoa on 2/10/21.
//

import Foundation
import ARKit

class ScanEvent {
    var session:ARSession
    var referenceObject:ARReferenceObject?
    var mergeObject:ARReferenceObject?
    var transform:simd_float4x4
    var center:simd_float3
    var extent:simd_float3
    var newName:String
    
    init(session:ARSession, referenceObject:ARReferenceObject?, mergeObject:ARReferenceObject?, transform: simd_float4x4, center: simd_float3, extent: simd_float3, newName:String) {
        self.session = session
        self.referenceObject = referenceObject
        self.mergeObject = mergeObject
        self.transform = transform
        self.center = center
        self.extent = extent
        self.newName = newName
    }
}
