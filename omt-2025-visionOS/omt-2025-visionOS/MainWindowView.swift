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
    
    var body: some View {        
        Text("OMT 2025")
            .font(.system(size: 72, weight: .heavy, design: .default))

        TimelineView(.animation) { context in
            Model3D(named: "Monkey2", bundle: realityKitContentBundle) { model in
                model
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .rotation3DEffect(.degrees(context.date.timeIntervalSinceReferenceDate * 30), axis: .y)
                    .frame(width: 500, height: 250)
            } placeholder: {
                ProgressView()
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    MainWindowView()
        .environment(AppModel())
}
