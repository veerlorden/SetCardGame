//
//  SetApp.swift
//  Set
//
//  Created by Вадим Буркин on 03.07.2021.
//

import SwiftUI

@main
struct SetApp: App {
    private let game = SetCardGame()
    
    var body: some Scene {
        WindowGroup {
            SetCardGameView(game: game)
        }
    }
}
