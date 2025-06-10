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
            if let scene = try? await Entity(named: "Volumetric", in: realityKitContentBundle) {
                content.add(scene)
            }
        }
        
    }
}
