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
import SwiftUI


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
        
        let subController = UIHostingController(rootView: _view)
        subController.view.translatesAutoresizingMaskIntoConstraints = false
        subController.view.frame = UIScreen.main.bounds
        //add the view of the child to the view of the parent
        view.addSubview(subController.view)

    }
    

    
    required init?(coder aDecoder: NSCoder)
        {
            super.init(coder: aDecoder)
        }
    

        
        
        func update(event:ScanEvent) -> Observable<ScanState> {
            return Observable.create { observer in
                switch event {
                    case is RequestARSCNView:
                        observer.on(.next(ViewStartState(view: self._repository!.sceneView)))
                    default:
                        observer.on(.next(ErrorState(message: "Operation Failed")))
                }
                observer.on(.completed)
                return Disposables.create()
        }
 

        
        
    }
    




 

}
    
    



    
    



