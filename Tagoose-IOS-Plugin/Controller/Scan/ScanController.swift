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
    
    func update(event:ScanEvent) -> Observable<ScanState> {
        return Observable.create { observer in
            if (self._repository.createReferenceObject(referenceObject: event.referenceObject, mergeObject: event.mergeObject, transform: event.transform, center: event.center, newName: event.newName) != nil) {
                observer.on(.next(SuccessfulScan()))
            }
            else {
                observer.on(.next(FailedScan(errorMessage: "Merge failed")))
                
            }
            observer.on(.completed)
            return Disposables.create()
        }
    }



    
    
}


