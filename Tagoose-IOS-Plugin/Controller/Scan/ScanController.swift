//
//  ScanController.swift
//  Tagoose-IOS-Plugin
//
//  Created by Hendrik Tjoa on 2/10/21.
//
//used for reference: https://stackoverflow.com/questions/60823803/how-to-add-a-cube-in-the-center-of-the-screen-and-so-that-it-never-leaves

import ARKit

import Foundation
import RxSwift
import RxCocoa


class ScanController: UIViewController {
    
    var _repository:ScanRepository?
    
    var _view:ScanView?
    
    init(_view: @escaping (@escaping (ScanEvent) -> (Observable<ScanState>)) -> (ScanView), _repository:ScanRepository) {
        super.init(nibName: nil, bundle: nil)
        self._view = _view(self.update)
        self._repository = _repository
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(_view!)

    }
    

    
    required init?(coder aDecoder: NSCoder)
        {
            super.init(coder: aDecoder)
        }
    

        
        
        func update(event:ScanEvent) -> Observable<ScanState> {
            return Observable.create { observer in
                switch event {
                    case is requestARSCNView:
                        observer.on(.next(ViewStartState(view: self._repository!.sceneView)))
                    default:
                        observer.on(.next(ErrorState(message: "Operation Failed")))
                }
                observer.on(.completed)
                return Disposables.create()
        }

        
        
    }
    



 

}
    
    



    
    



