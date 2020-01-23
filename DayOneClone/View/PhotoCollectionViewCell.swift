//
//  PhotoCollectionViewCell.swift
//  DayOneClone
//
//  Created by rau4o on 11/7/19.
//  Copyright © 2019 rau4o. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        return imageView
    }()
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 52)
        return label
    }()
    
    let monthLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    // MARK: - Initial method
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    // MARK: - Helper function
    
    private func configureUI() {
        addSubview(imageView)
        imageView.addSubview(dayLabel)
        imageView.addSubview(monthLabel)
        
        imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))
        monthLabel.anchor(top: nil, leading: imageView.leadingAnchor, bottom: imageView.bottomAnchor, trailing: imageView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 20))
        dayLabel.anchor(top: nil, leading: monthLabel.leadingAnchor, bottom: monthLabel.topAnchor, trailing: monthLabel.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 50))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
