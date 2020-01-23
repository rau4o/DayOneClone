//
//  PhotoCollectionVIewController.swift
//  DayOneClone
//
//  Created by rau4o on 11/7/19.
//  Copyright © 2019 rau4o. All rights reserved.
//

import UIKit
import RealmSwift

class PhotoCollectionVIewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    // MARK: - Properties
    
    private let cellId = "cellId"
    
    var pictures: Results<Picture>?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        createCollectionView()
        configureNavBar()
        //gello
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getPictures()
    }
    
    // MARK: - Helper function
    
    func configureNavBar() {
        title = "Day One Clone"
        navigationController?.navigationBar.barTintColor = UIColor(red: 83/255, green: 194/255, blue: 249/255, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
    }
    
    func getPictures() {
        if let realm = try? Realm() {
            pictures = realm.objects(Picture.self)
            collectionView.reloadData()
        }
    }
    
    func createCollectionView(){
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
        }
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .gray
        collectionView?.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    // MARK: - Collectionview functions
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let pictures = self.pictures {
            return pictures.count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? PhotoCollectionViewCell {
            if let picture = pictures?[indexPath.row] {
                cell.imageView.image = picture.thumbnail()
                cell.dayLabel.text = picture.entry?.dayPrettyString()
                cell.monthLabel.text = picture.entry?.monthYearPrettyString()
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 180)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = JournalDetailViewController()
        if let entry = pictures?[indexPath.item].entry{
            vc.entry = entry
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
