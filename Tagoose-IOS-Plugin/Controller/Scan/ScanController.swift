//
//  ScanController.swift
//  Tagoose-IOS-Plugin
//
//  Created by Hendrik Tjoa on 2/10/21.
//

import ARKit

import Foundation
import RxSwift
import RxCocoa


class ScanController {
    
    var _repository:ScanRepository
    
    init(repositoryCreator:() -> ScanRepository) {
        self._repository = repositoryCreator()
    }


    
    
}


