//
//  Shape+Extension.swift
//  Set
//
//  Created by Вадим Буркин on 21.07.2021.
//

import SwiftUI

extension Shape {
    
    func open() -> some View {
        ZStack {
            self.fill().foregroundColor(.white)
            self.stroke(lineWidth: 3)
        }
    }
    
    func striped() -> some View {
        ZStack {
            self.fill().foregroundColor(.white)
            self.stroke(lineWidth: 3)
            StripedRect().stroke().clipShape(self)
        }
    }
    
    func solid() -> some View {
        self.fill()
    }
}
