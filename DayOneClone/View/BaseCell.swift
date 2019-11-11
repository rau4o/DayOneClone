//
//  BaseCell.swift
//  DayOneClone
//
//  Created by rau4o on 11/8/19.
//  Copyright © 2019 rau4o. All rights reserved.
//

import UIKit

class BaseCell: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
        
    }
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       

}
