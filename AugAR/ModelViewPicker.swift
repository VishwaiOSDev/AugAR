//
//  ModelViewPicker.swift
//  AugAR
//
//  Created by Vishweshwaran on 10/10/20.
//

import Foundation
import SwiftUI

struct ModelViewPicker : View {
    
    @Binding var isPlacementEnabled : Bool
    @Binding var selectedModel : Model?
    
    var models : [Model]
    
    var body: some View{
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing : 30){
                ForEach(0 ..< models.count){ index in
                    Button(action: {
                        print("DEBUG : Selected Model is \(models[index].modelName)")
                        self.selectedModel = self.models[index]
                        self.isPlacementEnabled = true
                    }, label: {
                        Image(uiImage: self.models[index].image).resizable().frame(height:80).aspectRatio(1/1,contentMode: .fit)
                            .background(Color.white)
                            .cornerRadius(12)
                    }).buttonStyle(PlainButtonStyle())
                }
            }
        }.padding(20)
        .background(Color.black.opacity(0.5))
        
    }
}



