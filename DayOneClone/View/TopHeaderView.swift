//
//  TopHeaderView.swift
//  DayOneClone
//
//  Created by rau4o on 11/8/19.
//  Copyright © 2019 rau4o. All rights reserved.
//

import UIKit

class TopHeaderView: BaseCell {
    
    var detailAction: (() -> Void)?
    var detailPhotoAction: (() -> Void)?
    
    let plusButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(addPostAction), for: .touchUpInside)
        button.setImage(#imageLiteral(resourceName: "add"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    let photoButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(photoAction), for: .touchUpInside)
        button.setImage(#imageLiteral(resourceName: "whiteCamera"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
    }()
    override func setupViews() {
        backgroundColor = UIColor(red: 83/255, green: 194/255, blue: 249/255, alpha: 1)
        addSubviews()
        setContraints()
    }
    
    private func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(photoButton)
        stackView.addArrangedSubview(plusButton)
        
    }

    private func setContraints() {
        stackView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))
        photoButton.anchor(top: stackView.topAnchor, leading: stackView.leadingAnchor, bottom: stackView.bottomAnchor, trailing: plusButton.leadingAnchor, padding: .init(top: 20, left: 20, bottom: 20, right: 20), size: .init(width: 100, height: 100))
        plusButton.anchor(top: photoButton.topAnchor, leading: photoButton.trailingAnchor, bottom: photoButton.bottomAnchor, trailing: stackView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 10, right: 30), size: .init(width: 70, height: 70))
    }
    
    @objc func addPostAction() {
        detailAction?()
    }
    
    @objc func photoAction() {
        detailPhotoAction?()
    }
}
