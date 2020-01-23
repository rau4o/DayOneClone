//
//  TabBarController.swift
//  DayOneClone
//
//  Created by rau4o on 11/7/19.
//  Copyright © 2019 rau4o. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    // MARK: - Properties
    
    let firstVC = JournalTableViewController()
    let secondVC = PhotoCollectionVIewController(collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stylize()
        setNavBar()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
    }
    
    // MARK: - Helper function
    
    func setNavBar() {
        UITabBar.appearance().tintColor = .blue
        tabBar.isTranslucent = false
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
    }
    
    private func stylize() {
        
//        firstVC.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "camera"), tag: 0)
//        secondVC.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "database"), tag: 1)
//        
        let tableVC = createNavController(vc: JournalTableViewController(), selected: #imageLiteral(resourceName: "database"), unselected: #imageLiteral(resourceName: "database"))
        let collectionViewVC = createNavController(vc: PhotoCollectionVIewController(collectionViewLayout: UICollectionViewFlowLayout()), selected: #imageLiteral(resourceName: "camera"), unselected: #imageLiteral(resourceName: "camera"))
        
        viewControllers = [tableVC, collectionViewVC]
        navigationController?.navigationBar.isTranslucent = true
        
        guard let items = tabBar.items else {return}

        for item in items {
            item.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        }
    }
}

// MARK: - Extension TabBarController

extension UITabBarController{
    func createNavController(vc: UIViewController, selected: UIImage, unselected: UIImage) -> UINavigationController {
        let viewController = vc
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = selected.resizeImage(targetSize: .init(width: 25, height: 25))
        navController.tabBarItem.selectedImage = unselected.resizeImage(targetSize: .init(width: 25, height: 25))
        return navController
    }
}

extension UIImage {
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    func createLogoImage(image: UIImage?,
                         size: CGFloat) -> UIImageView{
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: size).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: size).isActive = true
        return imageView
    }
    
}
