//
//  MonkeyARView.swift
//  omt-2025-visionOS
//
//  Created by John Forester on 6/8/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct MonkeyARView: View {
    var body: some View {
        RealityView { content in
            if let scene = try? await Entity(named: "ARScene", in: realityKitContentBundle) {
                content.add(scene)

                if let root = scene.children.first,
                   let animationLibrary = root.components[AnimationLibraryComponent.self],
                   let animationResource = animationLibrary.defaultAnimation {
                    root.playAnimation(animationResource, transitionDuration: 0, startsPaused: false)
                }
            }
        }
    }
}
