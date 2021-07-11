//
//  DrawingListViewController.swift
//  SketchApp
//
//  Created by 김문옥 on 2021/07/11.
//

import UIKit
import PencilKit

class DrawingListViewController: UIViewController {
    // MARK: - Declarations
    
    let drawingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(DrawingCell.self, forCellWithReuseIdentifier: DrawingCell.reuseIdentifier)
        
        return collectionView
    }()
    
    let drawings: [DrawingModel]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawingCollectionView.dataSource = self
        drawingCollectionView.delegate = self

        view.addSubview(drawingCollectionView)
        
        drawingCollectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        drawingCollectionView.reloadData()
    }
    
    init(withDrawings drawings: [DrawingModel]) {
        self.drawings = drawings
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

// MARK: UICollectionViewDataSources

extension DrawingListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drawings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DrawingCell.reuseIdentifier, for: indexPath) as! DrawingCell
        let drawingData = drawings[indexPath.item].drawingData
        
        if let drawing = try? PKDrawing(data: drawingData) {
            cell.imageView.image = drawing.image(from: drawing.bounds, scale: 1.0)
        }
        
        return cell
    }
}

// MARK: UICollectionView

extension DrawingListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = CGFloat(floorf(Float(self.view.frame.width) / 3))
        return CGSize(width: width, height: width)
    }
}
