//
//  ScanControls.swift
//  Tagoose-IOS-Plugin
//
//  Created by Hendrik Tjoa on 2/19/21.
//

import Foundation
import SwiftUI
import RxSwift

struct ScanControls: View {
    
    var update: ((ScanEvent) -> (Observable<ScanState>))
    
    init(update: @escaping ((ScanEvent) -> (Observable<ScanState>))) {
        self.update = update
    }
    

    @State var msg: String = "Scan"
    
    var body: some View {
            VStack {
                Spacer()
                
                Button(action: {
                    self.update((ToggleCube())).subscribe(
                        onNext: { state in
                            let newState = state as! ToggleCubeState
                            msg = newState.message
                        }
                    )
                }) {
                    HStack {
                        Text(msg)
                    }.padding(10.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(lineWidth: 2.0)
                    )
                }
                
                
            }
        }
    
    
    
}
