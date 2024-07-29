//
//  NestedTableViewCellWithCollection.swift
//  Qarva
//
//  Created by Guga Valashvili on 28.07.24.
//

import Foundation
import UIKit

class NestedTableViewCellWithCollection: UITableViewCell  {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionLabel: UILabel!
    var models = [Model]()
    
    static let identifier = "NestedTableViewCellWithCollection"
    
    static func nib() -> UINib {
        return UINib(nibName: "NestedTableViewCellWithCollection", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MyCollectionViewCell.nib(), forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
    }
    
    func configure(with models: [Model]) {
        self.models = models
        collectionView.reloadData()
    }
    
}

extension NestedTableViewCellWithCollection: UICollectionViewDelegate, UICollectionViewDataSource,
                                             UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfSectionsInCollectionView section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as! MyCollectionViewCell
        cell.configure(with: models[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 3, height: 220)
    }
}
