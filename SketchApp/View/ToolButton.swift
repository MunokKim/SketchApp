//
//  ToolButton.swift
//  SketchApp
//
//  Created by 김문옥 on 2021/07/11.
//

import UIKit

class ToolButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)

        configueAppearances()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configueAppearances() {
        backgroundColor = .systemGray
        
        snp.makeConstraints { (make) in
            make.width.height.equalTo(36)
        }
    }
    
    override func draw(_ rect: CGRect) {
        tintColor = .systemBackground
        clipsToBounds = true
        layer.cornerRadius = 10
        titleLabel?.font = titleLabel?.font.withSize(10)
    }
}
