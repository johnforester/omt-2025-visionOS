//
//  AnimationPicker.swift
//  omt-2025-visionOS
//
//  Created by John Forester on 6/9/25.
//

import SwiftUI
import RealityKit

import SwiftUI

final class AnimationSelectionModel: ObservableObject {
    @Published var selectedAnimation: String?
    let availableAnimations: [String]

    init(from asset: Model3DAsset) {
        self.availableAnimations = asset.availableAnimations.map(\.path)
        self.selectedAnimation = availableAnimations.first
    }
}

struct AnimationPicker: View {
    let asset: Model3DAsset
    @StateObject private var model: AnimationSelectionModel

    init(asset: Model3DAsset) {
        self.asset = asset
        _model = StateObject(wrappedValue: AnimationSelectionModel(from: asset))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Picker("Animation", selection: $model.selectedAnimation) {
                ForEach(model.availableAnimations, id: \.self) { animation in
                    Text(animation).tag(Optional(animation))
                }
            }
            .pickerStyle(.menu)
        }
    }
}
