//
//  JournalTableViewController.swift
//  DayOneClone
//
//  Created by rau4o on 11/7/19.
//  Copyright © 2019 rau4o. All rights reserved.
//

import UIKit
import RealmSwift

class JournalTableViewController: UIViewController {
    
    private let cellId = "cellId"
    
    var topHeaderView: TopHeaderView!
    
    let entry = Entry()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(JournalTableViewCell.self, forCellReuseIdentifier: cellId)
        return tableView
    }()
    
    var entries: Results<Entry>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        setupTableView()
        self.topHeaderView.detailAction = toDetailVC
        self.topHeaderView.detailPhotoAction = toDetailPhotoVC
        title = "Day One Clone"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        
    }
    
    func getEntries() {
        if let realm = try? Realm() {
            entries = realm.objects(Entry.self).sorted(byKeyPath: "date", ascending: false)
            tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getEntries()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        let mainView = TopHeaderView(frame: self.view.frame)
        self.topHeaderView = mainView
        view.addSubview(topHeaderView)
        topHeaderView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 200))
        tableView.anchor(top: topHeaderView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))
    }
    
    func toDetailVC() {
        let vc = CreateJournalViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    func toDetailPhotoVC() {
        let vc = CreateJournalViewController()
        vc.startWithCamera = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension JournalTableViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let entries = self.entries {
            return entries.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? JournalTableViewCell {
            
            if let entry = entries?[indexPath.row] {
                cell.previewTextLabel.text = entry.text
                if let image = entry.pictures.first?.thumbnail() {
                    cell.photoImageView.image = image
                }
                else {
                    //
                }
                cell.monthLabel.text = entry.monthPrettyString()
                cell.dayLabel.text = entry.dayPrettyString()
                cell.yearLabel.text = entry.yearPrettyString()
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = JournalDetailViewController()
        if let entry = entries?[indexPath.row]{
            vc.entry = entry
//            vc.imageView = entry.pictures.first?.thumbnail()
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
