//
//  omt_2025_visionOSApp.swift
//  omt-2025-visionOS
//
//  Created by John Forester on 6/7/25.
//

import SwiftUI

enum ViewMode {
    case window
    case volumetric
    case immersive
    case ar
}

@main
struct omt_2025_visionOSApp: App {
    @State private var appModel = AppModel()
    @State private var currentMode: ViewMode = .window
    @State private var showImmersiveSpace = false
    @State private var immersionStyle: ImmersionStyle = .full

    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    var body: some Scene {
        WindowGroup(id: "MainWindow") {
            MainWindowView()
                .environment(appModel)
                .ornament(attachmentAnchor: .scene(.bottom), ornament: {
                    HStack(spacing: 16) {
                        Button {
                            Task {
                                await switchToMode(.window)
                            }
                        } label: {
                            Label {
                                Text("Window")
                            } icon: {
                                Image(systemName: "macwindow")
                            }
                        }
                        .disabled(currentMode == .window || appModel.immersiveSpaceState == .inTransition)
                        
                        Button {
                            Task {
                                await switchToMode(.volumetric)
                            }
                        } label: {
                            Label {
                                Text("Volumetric")
                            } icon: {
                                Image(systemName: "cube")
                            }
                        }
                        .disabled(currentMode == .volumetric || appModel.immersiveSpaceState == .inTransition)
                        
                        Button {
                            Task {
                                await switchToMode(.immersive)
                            }
                        } label: {
                            Label {
                                Text("Immersive")
                            } icon: {
                                Image(systemName: "visionpro")
                            }
                        }
                        .disabled(currentMode == .immersive || appModel.immersiveSpaceState == .inTransition)
                        
                        Button {
                            Task {
                                await switchToMode(.ar)
                            }
                        } label: {
                            Label {
                                Text("AR")
                            } icon: {
                                Image(systemName: "arkit")
                            }
                        }
                        .disabled(currentMode == .ar || appModel.immersiveSpaceState == .inTransition)
                    }
                    .padding()
                })
        }

        // Volumetric Window
        WindowGroup(id: "VolumetricWindow") {
            VolumetricView()
                .environment(appModel)
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 0.5, height: 0.5, depth: 0.5, in: .meters)

        ImmersiveSpace(id: appModel.immersiveSpaceID) {
            ImmersiveView()
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                    // Reset to window mode when immersive space closes
                    currentMode = .window
                }
        }
        .immersionStyle(selection: .constant(.full), in: .full)
        
        // AR Immersive Space
        ImmersiveSpace(id: appModel.arSpaceID) {
            MonkeyARView()
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                    // Reset to window mode when AR space closes
                    currentMode = .window
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
    }
    
    func switchToMode(_ mode: ViewMode) async {
        // Exit current mode first
        switch currentMode {
        case .window:
           // nothing to dismiss
            break
            
        case .volumetric:
            dismissWindow(id: "VolumetricWindow")
            
        case .immersive:
            appModel.immersiveSpaceState = .inTransition
            await dismissImmersiveSpace()
            
        case .ar:
            appModel.immersiveSpaceState = .inTransition
            await dismissImmersiveSpace()
        }
        
        // Enter new mode
        switch mode {
        case .window:
            currentMode = .window
            
        case .volumetric:
            currentMode = .volumetric
            openWindow(id: "VolumetricWindow")
            
        case .immersive:
            appModel.immersiveSpaceState = .inTransition
            switch await openImmersiveSpace(id: appModel.immersiveSpaceID) {
            case .opened:
                currentMode = .immersive
            case .userCancelled, .error:
                appModel.immersiveSpaceState = .closed
                currentMode = .window
            @unknown default:
                appModel.immersiveSpaceState = .closed
                currentMode = .window
            }
            
        case .ar:
            appModel.immersiveSpaceState = .inTransition
            switch await openImmersiveSpace(id: "ARSpace") {
            case .opened:
                currentMode = .ar
            case .userCancelled, .error:
                appModel.immersiveSpaceState = .closed
                currentMode = .window
            @unknown default:
                appModel.immersiveSpaceState = .closed
                currentMode = .window
            }
        }
    }
}

