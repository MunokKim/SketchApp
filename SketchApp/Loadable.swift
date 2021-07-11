//
//  Loadable.swift
//  SketchApp
//
//  Created by 김문옥 on 2021/07/11.
//

import UIKit

protocol Loadable: AnyObject {
    func setDrawing(withData drawingData: Data)
}
