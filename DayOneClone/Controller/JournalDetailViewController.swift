//
//  JournalDetailViewController.swift
//  DayOneClone
//
//  Created by rau4o on 11/7/19.
//  Copyright © 2019 rau4o. All rights reserved.
//

import UIKit
import RealmSwift

class JournalDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .white
        stackView.axis = .vertical
        stackView.alignment = .fill
        return stackView
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    let journalTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 10
        label.sizeToFit()
        return label
    }()
    
    var entry: Entry?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        showImages()
    }
    
    // MARK: - Helper function
    
    func configureUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(journalTextLabel)
        
        scrollView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))
        stackView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))
        
        journalTextLabel.anchor(top: stackView.topAnchor, leading: stackView.leadingAnchor, bottom: nil, trailing: stackView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: view.frame.width, height: 150))
    }
    
    fileprivate func showImages() {
        if let entry = self.entry {
            title = entry.datePrettyString()
        
            journalTextLabel.text = entry.text
        
            for picture in entry.pictures {
                let imageView = UIImageView()
                let ratio = picture.fullImage().size.height / picture.fullImage().size.width
                imageView.backgroundColor = .orange
                imageView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1.0)
                imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: ratio).isActive = true
                imageView.contentMode = .scaleAspectFit
                imageView.image = picture.fullImage()
                stackView.addArrangedSubview(imageView)
            }
        }
        else {
            journalTextLabel.text = ""
        }
    }
}
