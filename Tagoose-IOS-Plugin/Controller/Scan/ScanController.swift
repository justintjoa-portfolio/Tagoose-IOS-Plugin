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
    
    var _repository_Loader:() -> ScanRepository
    
    lazy var _repository:ScanRepository = _repository_Loader()
    
    init(repositoryCreator: @escaping () -> ScanRepository) {
        self._repository_Loader = repositoryCreator
    }
    

 

}
    
    



    
    



