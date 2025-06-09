//
//  ImmersiveView.swift
//  omt-2025-visionOS
//
//  Created by John Forester on 6/7/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {

    var body: some View {
        RealityView { content in
            if let immersiveContentEntity = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
                content.add(immersiveContentEntity)

                
                // Challenges:
                // 1) Add a skybox (See example here: https://developer.apple.com/documentation/realitykit/construct-an-immersive-environment-for-visionos)
                
                // 2) Make the monkey circle the banana
            }
        }
    }
}

#Preview(immersionStyle: .full) {
    ImmersiveView()
        .environment(AppModel())
}
