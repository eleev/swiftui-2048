//
//  AboutView.swift
//  T2iles
//
//  Created by Astemir Eleev on 30.05.2020.
//  Copyright © 2020 Astemir Eleev. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    // MARK: - Properties
    
    private let plist = PlistConfiguration(name: "Strings")
    private let about: [String : [String : String]]
    
    // MARK: - Initializers
    
    init() {
        about = plist?.getItem(named: PlistConfigurationKeyPath.about.rawValue) ?? ["" : [:]]
    }
    
    // MARK: - Conformance to View protocol
    
    var body: some View {
        GeometryReader { proxy in
            iconHeader(padding: UIDevice.current.userInterfaceIdiom == .pad ? 64 : 32, proxy: proxy)
            
            HStack {
                Text(about[PlistConfigurationKeyPath.about.rawValue]?[PlistConfigurationKeyPath.copyright.rawValue] ?? "[Missing Information]")
                    .font(Font.system(.callout, design: .monospaced).weight(.bold))
                    .foregroundColor(.secondary)
            }
            .position(x: proxy.frame(in: .local).midX, y: proxy.frame(in: .local).maxY)
            
        }
        .padding(.bottom, 24)
        .padding([.leading, .trailing], 48)
    }

    // MARK: - Private Methods

    private func iconHeader(padding spacing: CGFloat, proxy: GeometryProxy) -> some View {
        VStack(spacing: 16) {
            Image("Icon")
                .resizable()
                .cornerRadius(proxy.size.width / 50)
                .aspectRatio(contentMode: .fit)
            Link(about[PlistConfigurationKeyPath.about.rawValue]?[PlistConfigurationKeyPath.linkDescription.rawValue] ?? "[Missing Information]",
                 destination: URL(string: about[PlistConfigurationKeyPath.about.rawValue]?[PlistConfigurationKeyPath.linkUrl.rawValue] ?? "")!)
                .multilineTextAlignment(.center)
        }
        .padding(.all, spacing)
        .center(in: .local, with: proxy)
    }
}

struct AboutView_Previews: PreviewProvider {
    
    static var previews: some View {
        AboutView()
    }
}
