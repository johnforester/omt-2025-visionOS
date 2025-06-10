# omt-2025-visionOS

# visionOS Starter Project - One More Thing 2025

# GO TO BRANCH jf/visionOS-26 for the new stuff (requires Xcode 26)

## 🎯 Overview

This starter project showcases four primary view modes available in visionOS:
- **Window Mode** - Traditional 2D window interface
- **Volumetric Mode** - 3D content in a bounded volume
- **Immersive Mode** - Fully immersive VR experience
- **AR Mode** - Mixed reality with passthrough

## 🚀 Getting Started

### View Modes

#### Window Mode (Default)
- Standard 2D interface
- Familiar iOS/macOS-style interactions
- Perfect for productivity apps

#### Volumetric Mode
- 3D content in a bounded box
- Great for showcasing 3D models
- Maintains spatial context

#### Immersive Mode
- Full VR experience
- Complete environment control
- Ideal for games and experiences

#### AR Mode
- Mixed reality with passthrough
- Real-world interaction
- Perfect for spatial utilities

## 🛠️ Customization

### Working with Reality Composer Pro

The immersive and AR content for this project is created in **Reality Composer Pro**. The RealityKitContent package contains all 3D scenes and assets.

#### Opening Reality Composer Pro
- In Xcode, locate `Packages > RealityKitContent > Package.realitycomposerpro`
- Add your own 3D models, scenes, animations, materials, etc!


#### Key Scenes
- **Immersive.usda** - Full VR environment with TODO
- **ARScene.usda** - AR content designed to blend with the real world TODO

### Adding Your Own Content

1. **Edit existing scenes** in Reality Composer Pro:
   - Open the `.usda` files
   - Add/modify 3D objects
   - Adjust lighting and materials
   - Set up animations in the timeline or even add physics!

2. **Create new scenes**:
   - File > New > Scene in Reality Composer Pro
   - Save the RealityKitContent package
   - Import into your RealityKit views (See ImmersiveView.swift)

### 📚 Sources of Truth

#### Apple Resources
- [Apple visionOS Documentation](https://developer.apple.com/visionos/)
- [RealityKit Framework](https://developer.apple.com/documentation/realitykit/)
- [SwiftUI for visionOS](https://developer.apple.com/documentation/swiftui/)
- [visionOS Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/designing-for-visionos)

#### Community & Non-Apple Resources
- [visionOS Developers Discord](https://discord.gg/visionosdev) - Great community, nice place to ask questions!
- [John Haney](https://github.com/johnhaney) - John has really nice starting points for visionOS (particularly AR) if you want to get the boilerplate code and a headstart
- [Awesome visionOS Resources](https://github.com/timmitra/visionosresources)


