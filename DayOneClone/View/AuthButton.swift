//
//  AuthButton.swift
//  DayOneClone
//
//  Created by rau4o on 1/23/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit

class AuthButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitleColor(UIColor(white: 1, alpha: 0.5), for: .normal)
        backgroundColor = .mainBlue
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        layer.cornerRadius = 5
        heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

