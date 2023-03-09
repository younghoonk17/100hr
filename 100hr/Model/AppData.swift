//
//  EColor.swift
//  100hr
//
//  Created by young hoon kim on 4/02/23.
//

import Foundation
import SwiftUI

class AppData: ObservableObject {
    @Published var rootViewId = UUID()

    @Published var quotes = [
        "You’ve gotta learn to love the grind. Because life is the grind.",
        "Sunflowers end up facing the sun, but they go through a lot of dirt to find their way there.",
        "Greatness is sifted through the grind, therefore don't despise the hard work now for surely it will be worth it in the end."
    ]
}
