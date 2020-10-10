//
//  PlacementButtons.swift
//  AugAR
//
//  Created by Vishweshwaran on 10/10/20.
//

import Foundation
import SwiftUI

struct PlacementButtonView : View{
    
    @Binding var isPlacementEnabled : Bool
    @Binding var selectedModel : Model?
    @Binding var modelConfirmedForPlacement : Model?

    
    var body : some View{
        HStack{
            //Cancel Button
            Button(action: {
                print("Cancel Button")
                self.resetButton()
                
            }, label: {
                Image(systemName: "xmark")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(20)
            })
            //Confirm Button
            Button(action: {
                print("Confirm Button")
                self.modelConfirmedForPlacement = self.selectedModel
                self.resetButton()
            }, label: {
                Image(systemName: "checkmark")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(20)
            })
        }
        
    }
    
    func resetButton(){
        self.isPlacementEnabled = false
        self.selectedModel = nil
    }
}
