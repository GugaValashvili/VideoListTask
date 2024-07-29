//
//  MyCollectionViewCell.swift
//  Qarva
//
//  Created by Guga Valashvili on 28.07.24.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var myLabel: UILabel!
    @IBOutlet var myImageView: UIImageView!

    static let identifier = "MyCollectionViewCell"
    
    static func nib() -> UINib {
        UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    public func configure(with model: Model) {
        self.myLabel.text = model.text
//        self.myImageView.image = UIImage(named: "Logo") 
    }

}
