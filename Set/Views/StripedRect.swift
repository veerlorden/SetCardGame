//
//  StripedRect.swift
//  Set
//
//  Created by Вадим Буркин on 21.07.2021.
//

import SwiftUI

struct StripedRect: Shape {
    let spacing: CGFloat = 5
    
    func path(in rect: CGRect) -> Path {
        let start = CGPoint(x: rect.minX, y: rect.minY)
        var p = Path()
        
        p.move(to: start)
        while p.currentPoint!.x < rect.maxX {
            p.addLine(to: CGPoint(x: p.currentPoint!.x, y: rect.maxY))
            p.move(to: CGPoint(x: p.currentPoint!.x + spacing, y: rect.minY))
        }
        
        return p
    }
}

struct StripedRect_Previews: PreviewProvider {
    static var previews: some View {
        StripedRect()
            .stroke()
            .frame(width: 300, height: 150)
            .foregroundColor(.green)
    }
}
