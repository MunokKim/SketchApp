//
//  Colors.swift
//  SketchApp
//
//  Created by 김문옥 on 2021/07/11.
//

import UIKit

enum Colors: String, CaseIterable {
    case primary
    case blue
    case red
    
    var color: UIColor {
        switch self {
        case .primary: return UIColor(named: "primaryColor")!
        case .blue: return UIColor.systemBlue
        case .red: return UIColor.systemRed
        }
    }
}
