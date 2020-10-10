//
//  ContentView.swift
//  AugAR
//
//  Created by Vishweshwaran on 10/10/20.
//

import SwiftUI
import RealityKit
import ARKit
import FocusEntity

struct ContentView : View {
    
    @State private var isPlacementEnabled = false
    @State private var selectedModel : Model?
    @State private var modelConfirmedForPlacement: Model?
    
    var models : [Model] = {
        
        let filemanager = FileManager.default
        
        guard let path = Bundle.main.resourcePath, let files = try? filemanager.contentsOfDirectory(atPath: path) else{
            return []
        }
        
        var availableModels : [Model]  = []
        
        for filename in files where
            filename.hasSuffix("usdz"){
            let modelName = filename.replacingOccurrences(of: ".usdz", with: "")
            
            let model = Model(modelName: modelName)
            
            availableModels.append(model)
        }
        
        return availableModels
        
    }()
    
    var body: some View {
        
        ZStack(alignment: .bottom){
            
            ARViewContainer(modelConfirmedForPlacement: self.$modelConfirmedForPlacement).edgesIgnoringSafeArea(.all)
            
            if self.isPlacementEnabled {
                PlacementButtonView(isPlacementEnabled: self.$isPlacementEnabled, selectedModel: self.$selectedModel, modelConfirmedForPlacement: self.$modelConfirmedForPlacement)
                
            }
            else {
                ModelViewPicker(isPlacementEnabled: self.$isPlacementEnabled, selectedModel: self.$selectedModel, models: self.models)
            }
            
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    @Binding var modelConfirmedForPlacement : Model?
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = CustomARView(frame: .zero)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
        if let model = self.modelConfirmedForPlacement{
            
            
            
            if let modelEntity = model.modelEntity{
                let anchorEntity = AnchorEntity(plane: .any)
                
                anchorEntity.addChild(modelEntity.clone(recursive: true))
                
                uiView.scene.addAnchor(anchorEntity)
            }else{
                print("Unable to load model entity..\(model.modelName)")
            }
            
            
            DispatchQueue.main.async {
                self.modelConfirmedForPlacement = nil
            }
            
            
        }
        
    }
    
}

class CustomARView : ARView{
    
    var focusEntity: FocusEntity?
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        self.setupConfig()
        self.focusEntity = FocusEntity(on: self, style: .classic)
        self.setupARView()
    }
    
    func setupConfig() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        session.run(config, options: [])
    }
    
    @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupARView(){
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal,.vertical]
        config.environmentTexturing = .automatic
        config.isLightEstimationEnabled = true
        
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh){
            config.sceneReconstruction = .mesh
        }
        
        self.session.run(config)
        
    }
}

extension CustomARView : FocusEntityDelegate {
    func toTrackingState() {
        print("tracking")
    }
    func toInitializingState() {
        print("initializing")
    }

}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
#endif
