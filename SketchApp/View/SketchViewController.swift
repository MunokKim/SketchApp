//
//  SketchViewController.swift
//  SketchApp
//
//  Created by 김문옥 on 2021/07/10.
//

import UIKit
import PencilKit
import SnapKit
import CoreData

class SketchViewController: UIViewController {
    // MARK: - Declarations
    
    var pen = PKInkingTool(.pen, color: ColorType.primary.color, width: 5)
    var marker = PKInkingTool(.marker, color: ColorType.primary.color, width: 20)
    var lasso = PKLassoTool()
    var eraser = PKEraserTool(.bitmap)
    
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
        let action = UIAction(title: "SAVE") { [unowned self] _ in
            guard canvasView.drawing.bounds.size != .zero && !canvasView.drawing.strokes.isEmpty else { return }
            let drawingData = canvasView.drawing.dataRepresentation()
            CoreDataManager.shared.save(withData: drawingData) { (error) in
                let alertTitle = error != nil ? error.debugDescription : "Save success!"
                let action = UIAlertAction(title: "Ok", style: .cancel) { _ in
                    self.dismiss(animated: true, completion: nil)
                }
                let alertController = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        let button = ToolButton(primaryAction: action)
        
        return button
    }()
    
    lazy var loadButton: ToolButton = {
        let action = UIAction(title: "LOAD") { [unowned self] _ in
            guard let drawings = CoreDataManager.shared.load()
            else { return }
            let drawingListViewController = DrawingListViewController(
                withDrawings: drawings,
                withLoadable: self
            )
            self.present(drawingListViewController, animated: true, completion: nil)
        }
        let button = ToolButton(primaryAction: action)
        
        return button
    }()
    
    lazy var addButton: ToolButton = {
        let action = UIAction(title: "ADD", handler: { _ in })
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
        let action = UIAction(image: image, handler: { _ in })
        let button = ToolButton(primaryAction: action)
        
        return button
    }()
    
    lazy var redoButton: ToolButton = {
        let image = UIImage(systemName: "arrow.forward")
        let action = UIAction(image: image, handler: { _ in })
        let button = ToolButton(primaryAction: action)
        
        return button
    }()
    
    lazy var penButton: ToolButton = {
        let primaryAction = UIAction(title: "PEN", handler: { _ in })
        let penActions = ColorType.allCases.map { (colorType) -> UIAction in
            return UIAction(image: UIImage(systemName: "pencil")!.withTintColor(colorType.color, renderingMode: .alwaysOriginal)) { [weak self] _ in
                guard let self = self else { return }
                self.pen.color = colorType.color
                self.canvasView.tool = self.pen
            }
        }
        let markerActions = ColorType.allCases.map { (colorType) -> UIAction in
            return UIAction(image: UIImage(systemName: "scribble.variable")!.withTintColor(colorType.color, renderingMode: .alwaysOriginal)) { [unowned self] _ in
                marker.color = colorType.color
                canvasView.tool = marker
            }
        }
        let lassoAction = UIAction(title: "Lasso", image: UIImage(systemName: "lasso")) { [unowned self] _ in
            canvasView.tool = lasso
        }
        
        let penMenu = UIMenu(title: "Pen", image: UIImage(systemName: "pencil"), children: penActions)
        let markerMenu = UIMenu(title: "Marker", image: UIImage(systemName: "scribble.variable"), children: markerActions)
        let menu = UIMenu(title: "Choose a pen", children: [penMenu, markerMenu, lassoAction])
        
        let button = ToolButton(primaryAction: primaryAction)
        button.menu = menu
        button.showsMenuAsPrimaryAction = true
        
        return button
    }()
    
    lazy var eraseButton: ToolButton = {
        let action = UIAction(title: "ERASE") { [unowned self] _ in canvasView.tool = eraser }
        let button = ToolButton(primaryAction: action)
        
        return button
    }()
    
    lazy var canvasView: PKCanvasView = {
        let view = PKCanvasView()
        view.backgroundColor = .systemBackground
        view.maximumZoomScale = 10
        view.minimumZoomScale = 1
        view.tool = pen
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

// MARK: - PKCanvasViewDelegate

extension SketchViewController: PKCanvasViewDelegate {
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        
    }
}

// MARK: - Loadable

extension SketchViewController: Loadable {
    func setDrawing(withData drawingData: Data) {
        guard let drawing = try? PKDrawing(data: drawingData) else { return }
        canvasView.drawing = drawing
    }
    
    func setScreenshot(withImage image: UIImage) {
        
    }
}
