//
//  JournalTableViewCell.swift
//  DayOneClone
//
//  Created by rau4o on 11/7/19.
//  Copyright © 2019 rau4o. All rights reserved.
//

import UIKit

class JournalTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let yearLabel: UILabel = {
        let label = UILabel()
        label.configureLabelCell()
        return label
    }()
    
    let monthLabel: UILabel = {
        let label = UILabel()
        label.configureLabelCell()
        return label
    }()
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.configureLabelCell()
        label.font = UIFont.systemFont(ofSize: 40)
        return label
    }()
    
    let photoImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5
        return image
    }()
    
    let previewTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.backgroundColor = .white
        label.numberOfLines = 15
        return label
    }()
    
    // MARK: - Initial method
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    // MARK: - Helper function
    
    private func configureUI() {
        addSubview(yearLabel)
        addSubview(monthLabel)
        addSubview(dayLabel)
        addSubview(previewTextLabel)
        addSubview(photoImageView)
        
        monthLabel.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 0), size: .init(width: 60, height: 21))
        dayLabel.anchor(top: monthLabel.bottomAnchor, leading: nil, bottom: nil, trailing: monthLabel.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 60, height: 58))
        yearLabel.anchor(top: dayLabel.bottomAnchor, leading: nil, bottom: bottomAnchor, trailing: monthLabel.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 5, right: 0), size: .init(width: 60, height: 21))
        photoImageView.anchor(top: monthLabel.topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: previewTextLabel.leadingAnchor, padding: .init(top: 5, left: 5, bottom: 5, right: 5), size: .init(width: 100, height: 100))
        previewTextLabel.anchor(top: monthLabel.topAnchor, leading: photoImageView.trailingAnchor, bottom: photoImageView.bottomAnchor, trailing: monthLabel.leadingAnchor, padding: .init(top: 0, left: 5, bottom: 0, right: 0), size: .init(width: 210, height: 100))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
