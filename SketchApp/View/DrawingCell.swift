//
//  DrawingCell.swift
//  SketchApp
//
//  Created by 김문옥 on 2021/07/11.
//

import UIKit

class DrawingCell: UICollectionViewCell {
    // MARK: - Declarations
    
    static let reuseIdentifier: String = String(describing: DrawingCell.self)
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    // MARK: - Life cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imageView)
        
        contentView.layer.borderColor = UIColor.systemFill.cgColor
        contentView.layer.borderWidth = 1.0
        
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
