//
//  NestedTableViewCell.swift
//  Qarva
//
//  Created by Guga Valashvili on 28.07.24.
//

import UIKit

class NestedTableViewCell: UITableViewCell {
    
    let customLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    let customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        contentView.addSubview(customLabel)
//        contentView.addSubview(customImageView)
        
        NSLayoutConstraint.activate([
            customLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            customLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            customLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 30)
        ])
        
        
        // Setup constraints for additional UI components if needed
    }
    
    func configure(with text: String) {
        customLabel.text = text
    }
}

