//
//  View+Center.swift
//  T2iles
//
//  Created by Astemir Eleev on 18.07.2020.
//  Copyright © 2020 Astemir Eleev. All rights reserved.
//

import SwiftUI

extension View {
    func center(in coordinateSpace: CoordinateSpace, with proxy: GeometryProxy) -> some View {
        let frame = proxy.frame(in: coordinateSpace)
        return position(x: frame.midX, y: frame.midY)
    }
}
