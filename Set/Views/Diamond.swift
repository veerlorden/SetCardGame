//
//  Diamond.swift
//  Set
//
//  Created by Вадим Буркин on 19.07.2021.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        let left = CGPoint(x: rect.minX, y: rect.midY)
        let top = CGPoint(x: rect.midX, y: rect.minY)
        let right = CGPoint(x: rect.maxX, y: rect.midY)
        let bottom = CGPoint(x: rect.midX, y: rect.maxY)

        
        var p = Path()
        
        p.move(to: left)
        p.addLine(to: top)
        p.addLine(to: right)
        p.addLine(to: bottom)
        p.addLine(to: left)
        
        return p
    }
}


struct Diamond_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Diamond()
                .solid()
                .frame(width: 300, height: 150)
            Diamond()
                .striped()
                .frame(width: 300, height: 150)
            Diamond()
                .open()
                .frame(width: 300, height: 150)
        }
        .foregroundColor(.green)
    }
}
