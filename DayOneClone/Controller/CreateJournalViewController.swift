//
//  CreateJournalViewController.swift
//  DayOneClone
//
//  Created by rau4o on 11/7/19.
//  Copyright © 2019 rau4o. All rights reserved.
//

import UIKit
import RealmSwift
import IQKeyboardManager

class CreateJournalViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    // MARK: - Properties
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
        
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    let textView: UITextView = {
       let text = UITextView()
       text.textAlignment = .left
       text.text = " Write something"
       text.backgroundColor = .white
       return text
    }()
       
    let datePicker: UIDatePicker = {
       let datePicker = UIDatePicker()
       datePicker.datePickerMode = .dateAndTime
       datePicker.backgroundColor = .white
       return datePicker
    }()
    
    let setDateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Set Date", for: .normal)
        button.backgroundColor = .mainBlue
        button.addTarget(self, action: #selector(handleSetDate), for: .touchUpInside)
        return button
    }()
    
    let blueCalendareButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "calendar"), for: .normal)
        button.addTarget(self, action: #selector(blueCalendareTapped), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    let blueCameraButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "blueCamera"), for: .normal)
        button.addTarget(self, action: #selector(blueCameraTapped), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .white
        return label
    }()
    
    var imagePicker = UIImagePickerController()
    var images: [UIImage] = []
    var startWithCamera = false
    var entry = Entry()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        configureUI()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = UIColor(red: 83/255, green: 194/255, blue: 249/255, alpha: 1)
        setupBarButton()
        
        imagePicker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.layer.zPosition = -5
        tabBarController?.tabBar.frame.size.height = 0
        tabBarController?.tabBar.backgroundColor = .white
        tabBarController?.tabBar.barTintColor = .white
        navigationController?.navigationBar.isHidden = false
        updateDate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if startWithCamera {
            startWithCamera = false
            blueCameraTapped()
        }
    }
    
    // MARK: - Helper function
    
    func setupBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(savePostAction))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
    }
    
    func showImagePicker() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func updateDate() {
        title = entry.datePrettyString()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let choosenImage = info[.originalImage] as? UIImage {
            images.append(choosenImage)
            let imageView = UIImageView()
            imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
            imageView.image = choosenImage
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            stackView.addArrangedSubview(imageView)
            imagePicker.dismiss(animated: true, completion: nil)
        }
    }
    
    private func configureUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        view.addSubview(textView)
        view.addSubview(datePicker)
        view.addSubview(setDateButton)
        
        stackView.addArrangedSubview(blueCalendareButton)
        stackView.addArrangedSubview(blueCameraButton)
        
        textView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 170))
        datePicker.anchor(top: textView.bottomAnchor, leading: textView.leadingAnchor, bottom: nil, trailing: textView.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 200))
        
        setDateButton.anchor(top: nil, leading: view.leadingAnchor, bottom: stackView.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 40))
        
        scrollView.anchor(top: setDateButton.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: view.frame.width, height: 70))
        stackView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: scrollView.frame.width, height: scrollView.frame.height))
            
        blueCalendareButton.anchor(top: stackView.topAnchor, leading: stackView.leadingAnchor, bottom: stackView.bottomAnchor, trailing: blueCameraButton.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 10), size: .init(width: 70, height: 70))
        blueCameraButton.anchor(top: blueCalendareButton.topAnchor, leading: blueCalendareButton.trailingAnchor, bottom: blueCalendareButton.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 70, height: 70))
        }
    
    // MARK: - Selectors
    
    @objc func savePostAction() {
        if let realm = try? Realm() {
            entry.text = textView.text
            for image in images {
                let picture = Picture(image: image)
                entry.pictures.append(picture)
                picture.entry = entry
            }
            try? realm.write {
                realm.add(entry)
            }
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func cancelAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSetDate() {
        textView.isHidden = false
        datePicker.isHidden = true
        setDateButton.isHidden = true
        entry.date = datePicker.date
        updateDate()
    }
    
    @objc func blueCalendareTapped() {
        textView.isHidden = true
        datePicker.isHidden = false
        setDateButton.isHidden = false
        datePicker.date = entry.date
    }
    
    @objc func blueCameraTapped() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
}
