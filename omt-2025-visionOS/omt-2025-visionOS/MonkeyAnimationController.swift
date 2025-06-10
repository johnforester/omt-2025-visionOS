//
//  MonkeyAnimationController.swift
//  omt-2025-visionOS
//
//  Created by John Forester on 6/9/25.
//

import SwiftUI
import RealityKit

struct MonkeyAnimationController: View {
    @Bindable var controller: AnimationPlaybackController
    
    var body: some View {
        HStack {
            Button (controller.isPlaying ? "Pause" : "Play") {
                if controller.isPlaying {
                    controller.pause()
                } else {
                    controller.resume()
                }
            }
            
            Slider (
                value: $controller.time,
                in: 0...controller.duration
            ).id(controller)
        }
    }
}
