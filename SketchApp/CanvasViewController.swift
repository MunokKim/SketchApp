//
//  CanvasViewController.swift
//  SketchApp
//
//  Created by 김문옥 on 2021/07/10.
//

import UIKit
import PencilKit
import SnapKit

class CanvasViewController: UIViewController {
    // MARK: - Views
    
    let toolBarView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray3
        
        return view
    }()
    
    let leftToolStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8.0
        
        return stackView
    }()
    
    lazy var saveButton: ToolButton = {
        let action = UIAction(title: "SAVE", handler: save)
        let button = ToolButton(primaryAction: action)
        button.titleLabel?.font = button.titleLabel?.font.withSize(4)
        
        return button
    }()
    
    lazy var loadButton: ToolButton = {
        let action = UIAction(title: "LOAD", handler: load)
        let button = ToolButton(primaryAction: action)
        
        return button
    }()
    
    lazy var addButton: ToolButton = {
        let action = UIAction(title: "ADD", handler: add)
        let button = ToolButton(primaryAction: action)
        
        return button
    }()
    
    let rightToolStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8.0
        
        return stackView
    }()
    
    lazy var undoButton: ToolButton = {
        let image = UIImage(systemName: "arrow.backward")
        let action = UIAction(image: image, handler: load)
        let button = ToolButton(primaryAction: action)
        
        return button
    }()
    
    lazy var redoButton: ToolButton = {
        let image = UIImage(systemName: "arrow.forward")
        let action = UIAction(image: image, handler: redo)
        let button = ToolButton(primaryAction: action)
        
        return button
    }()
    
    lazy var penButton: ToolButton = {
        let action = UIAction(title: "PEN", handler: pen)
        let button = ToolButton(primaryAction: action)
        
        return button
    }()
    
    lazy var eraseButton: ToolButton = {
        let action = UIAction(title: "ERASE", handler: erase)
        let button = ToolButton(primaryAction: action)
        
        return button
    }()
    
    let canvasView: PKCanvasView = {
        let view = PKCanvasView()
        view.backgroundColor = .systemBackground
        view.maximumZoomScale = 10
        view.minimumZoomScale = 0.1
        view.tool = PKInkingTool(.pen, color: .black, width: 5)
        view.drawingPolicy = .anyInput
        
        return view
    }()
    
    // MARK: - Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        canvasView.delegate = self
        
        configueUI()
        setConstraints()
    }
    
    // MARK: - UIs

    private func configueUI() {
        view.addSubview(toolBarView)
        toolBarView.addSubview(leftToolStackView)
        leftToolStackView.addArrangedSubview(saveButton)
        leftToolStackView.addArrangedSubview(loadButton)
        leftToolStackView.addArrangedSubview(addButton)
        toolBarView.addSubview(rightToolStackView)
        rightToolStackView.addArrangedSubview(undoButton)
        rightToolStackView.addArrangedSubview(redoButton)
        rightToolStackView.addArrangedSubview(penButton)
        rightToolStackView.addArrangedSubview(eraseButton)
        view.addSubview(canvasView)
        
        leftToolStackView.setCustomSpacing(20.0, after: loadButton)
        rightToolStackView.setCustomSpacing(20.0, after: redoButton)
    }
    
    private func setConstraints() {
        toolBarView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        
        leftToolStackView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
        }
        
        rightToolStackView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-12)
        }
        
        canvasView.snp.makeConstraints { (make) in
            make.top.equalTo(toolBarView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - button handlers

extension CanvasViewController {
    private func save(_ action: UIAction) {
        
    }
    
    private func load(_ action: UIAction) {
        
    }
    
    private func add(_ action: UIAction) {
        
    }
    
    private func undo(_ action: UIAction) {
        
    }
    
    private func redo(_ action: UIAction) {
        
    }
    
    private func pen(_ action: UIAction) {
        
    }
    
    private func erase(_ action: UIAction) {
        
    }
}

// MARK: - PKCanvasViewDelegate

extension CanvasViewController: PKCanvasViewDelegate {
    
}
