//
//  ContentView.swift
//  omt-2025-visionOS
//
//  Created by John Forester on 6/7/25.
//

import Foundation
import SwiftUI
import RealityKit
import RealityKitContent

struct MainWindowView: View {
    
    @State private var monkeyAsset: Model3DAsset?
    
    var body: some View {
        Text("OMT 2025")
            .font(.system(size: 72, weight: .heavy, design: .default))
        
       /* TimelineView(.animation) { context in
            Model3D(named: "Monkey2", bundle: realityKitContentBundle) { model in
                model
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .rotation3DEffect(.degrees(context.date.timeIntervalSinceReferenceDate * 30), axis: .y)
                    .frame(width: 500, height: 250)
            } placeholder: {
                ProgressView()
            }
        }*/
        
        if monkeyAsset == nil {
            ProgressView().task {
                monkeyAsset = try? await Model3DAsset(named: "Monkey2.usdz")
                
                // NEED TO SELECT A STARTING ANIMATION
                monkeyAsset?.selectedAnimation = monkeyAsset?.availableAnimations.first
            }
        } else if let monkeyAsset {
            VStack {
                Model3D(asset: monkeyAsset) { model in
                    model
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 500, height: 250)
                }
                                
                AnimationPicker(asset: monkeyAsset)
                
                if let animationController = monkeyAsset.animationPlaybackController {
                    MonkeyAnimationController(controller: animationController)
                }
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    MainWindowView()
        .environment(AppModel())
}
