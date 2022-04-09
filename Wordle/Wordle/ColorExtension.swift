//
//  ColorExtension.swift
//  Wordle
//
//  Created by Hanson on 2022/4/3.
//

import SwiftUI

extension Color {
    static var none: Color {
        Color(red:255/255, green: 68/255, blue: 93/255)
    }
    static var included: Color {
        Color(red: 57/255, green: 188/255, blue: 224/255)
    }
    static var match: Color {
        Color(red: 46/255, green: 220/225, blue: 171/255)
    }
    static var unused: Color {
        Color(red: 214/255, green: 217/255, blue: 227/255)
    }
    static var systemBackground: Color {
        Color(.systemBackground)
    }
}
