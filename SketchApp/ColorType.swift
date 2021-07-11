//
//  ColorType.swift
//  SketchApp
//
//  Created by 김문옥 on 2021/07/11.
//

import UIKit

enum ColorType: String, CaseIterable {
    case primary
    case blue
    case red
    case orange
    case green
    case purple
    case yellow
    case pink
    
    var color: UIColor {
        switch self {
        case .primary: return UIColor(named: "primaryColor")!
        case .blue: return UIColor.systemBlue
        case .red: return UIColor.systemRed
        case .orange: return UIColor.systemOrange
        case .green: return UIColor.systemGreen
        case .purple: return UIColor.systemPurple
        case .yellow: return UIColor.systemYellow
        case .pink: return UIColor.systemPink
        }
    }
}
