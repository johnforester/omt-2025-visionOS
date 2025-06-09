//
//  VolumetricView.swift
//  omt-2025-visionOS
//
//  Created by John Forester on 6/8/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct VolumetricView: View {
    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let scene = try? await Entity(named: "Volumetric", in: realityKitContentBundle) {
                content.add(scene)
            }
        } update: { content in
            // TODO
        }
        .gesture(TapGesture().targetedToAnyEntity().onEnded { _ in
            // TODO
        })
        .toolbar {
            ToolbarItemGroup(placement: .bottomOrnament) {
                VStack (spacing: 12) {
                   // TODO
                }
            }
        }
    }
}
