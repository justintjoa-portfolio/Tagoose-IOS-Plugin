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
    
    var body: some View {
            VStack {
                Spacer()
                
                Button(action: {
                    print("Hi!")
                }) {
                    HStack {
                        Text("Increment")
                    }.padding(10.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(lineWidth: 2.0)
                    )
                }
                
                
            }
        }
    
    
    
}
