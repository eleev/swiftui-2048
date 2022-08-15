//
//  TileBoardSettingView.swift
//  T2iles
//
//  Created by Astemir Eleev on 08.06.2020.
//  Copyright © 2020 Astemir Eleev. All rights reserved.
//

import SwiftUI

struct TileBoardSettingView: View {

    // MARK:  
    
    @State private var selection = GameBoardSizeState()

    var invertedBackgroundColor: Color
    var previewSize: CGSize
    
    var body: some View {
        VStack {
            boardSizeSettingView(imageAssetName: "3x3", isSelected: $selection.is3x3On)
                .onTapGesture {
                    if !selection.is3x3On {
                        selection.is3x3On = true
                    }
            }
            boardSizeSettingView(imageAssetName: "4x4", isSelected: $selection.is4x4On)
                .onTapGesture {
                    if !selection.is4x4On {
                        selection.is4x4On = true
                    }
            }
            boardSizeSettingView(imageAssetName: "5x5", isSelected: $selection.is5x5On)
                .onTapGesture {
                    if !selection.is5x5On {
                        selection.is5x5On = true
                    }
            }
        }
    }
    
    private func boardSizeSettingView(imageAssetName: String, isSelected: Binding<Bool>) -> some View {
        // Prevent the toggle to be turned off in cases when all the other selection states are false
        if !selection.is3x3On && !selection.is4x4On && !selection.is5x5On {
            DispatchQueue.main.async {
                isSelected.wrappedValue = true
            }
        }
        
        return Toggle(isOn: isSelected) {
            Image(imageAssetName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: previewSize.height)
        }
        .toggleStyle(CheckboxToggleStyle())
        .foregroundColor(Color.primary.opacity(0.5))
        .opacity(isSelected.wrappedValue ? 1.0 : 0.5)
        .shadow(
            color: invertedBackgroundColor.opacity(0.5),
            radius: isSelected.wrappedValue ? 10 : 0
        )
        .animation(.modalSpring, value: isSelected.wrappedValue)
        .padding([.top, .bottom])
    }
}
