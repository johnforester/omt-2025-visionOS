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
    @State var scene: Entity?
    @State var monkey: Entity?
    
    var body: some View {
        RealityView { content in
            if let scene = try? await Entity(named: "ARScene", in: realityKitContentBundle) {
                self.scene = scene
                content.add(scene)
                
                if let root = scene.children.first,
                   let animationLibrary = root.components[AnimationLibraryComponent.self],
                   let animationResource = animationLibrary.defaultAnimation {
                    monkey = root
                    root.playAnimation(animationResource, transitionDuration: 0, startsPaused: false)
                }
            }
            
            await addBanana()
        }
    }
    
    func addBanana() async {
        do {
            let bananaEntity = try await ModelEntity(named: "Banana.usdz")
            
            var meshInstancesComponent = MeshInstancesComponent()
            let instances = try LowLevelInstanceData(instanceCount: 200)
            meshInstancesComponent[partIndex: 0] = instances
            
            instances.withMutableTransforms { transforms in
                for i in 0..<200 {
                    let scale: Float = .random(in: 1...10)
                    let angle: Float = .random(in: 0..<2) * .pi
                    let randomX: Float = .random(in: -50...50)
                    let randomZ: Float = .random(in: -50...50)
                    let position = SIMD3<Float>(x: randomX, y: 0, z: randomZ)
                    let transform = Transform(
                        scale: .init(repeating: scale),
                        rotation: .init(angle: angle, axis: [0, 1, 0]),
                        translation: position
                    )
                    transforms[i] = transform.matrix
                }
            }
            
            bananaEntity.components.set(meshInstancesComponent)
            
            scene?.addChild(bananaEntity)
        } catch {
            print("Failed to add banana entity: \(error)")
        }
    }

}
