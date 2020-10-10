//
//  Model.swift
//  AugAR
//
//  Created by Vishweshwaran on 10/10/20.
//

import UIKit
import RealityKit
import Combine

class Model {
    var modelName : String
    var image : UIImage
    var modelEntity : ModelEntity?
    
    private var cancellable : AnyCancellable? = nil
    
    init(modelName : String) {
        self.modelName = modelName
        self.image = UIImage(named: modelName)!
        
        let filename = modelName + ".usdz"
        self.cancellable = ModelEntity.loadModelAsync(named: filename).sink(receiveCompletion: { loadCompletion in
            //Handle Error
            print("DEBUG : Unable to load modelEnitiy for modelname : \(self.modelName)")
            
        }, receiveValue: { modelEntity in
            //Get out modelEnitiy
            self.modelEntity = modelEntity
            print("DEBUG: Successfully Loaded the model - \(self.modelName)")
        })
        
        
    }
}


