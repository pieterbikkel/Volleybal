//
//  SettingsController.swift
//  HamburgerMenu
//
//  Created by Pieter Bikkel on 03/04/2020.
//  Copyright © 2020 Pieter Bikkel. All rights reserved.
//

import UIKit

class InstellingenController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    
    struct Cells {
        static let InstellingenCell = "InstellingenCell"
    }
    
    private let refreshControl = UIRefreshControl()
    
    var instellingenTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    var username: String?
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
        view.backgroundColor = .blue
        //print(username!)
        
    }
    
    // MARK: - Selectors

    
    
    // MARK: - Helper Functions
    
    func configureTableView() {
        view.addSubview(instellingenTableView)
        instellingenTableView.register(InstellingenCell.self, forCellReuseIdentifier: Cells.InstellingenCell)
        instellingenTableView.delegate = self
        instellingenTableView.dataSource = self
        instellingenTableView.frame = view.frame
        instellingenTableView.rowHeight = 60
        instellingenTableView.separatorStyle = .none
        instellingenTableView.backgroundColor = UIColor(named: "bg")
        instellingenTableView.alwaysBounceVertical = false
    }

    func configureNavigationBar() {
        //navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .mainOrange()
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.mainOrange()]
        navigationItem.standardAppearance = appearance
        
        view.backgroundColor = UIColor(named: "bg")
        navigationItem.title = "Instellingen"
    }
    
    // MARK: - Tableview
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = instellingenTableView.dequeueReusableCell(withIdentifier: Cells.InstellingenCell, for: indexPath) as! InstellingenCell
        
        guard let section = SettingsSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .Favorieten: cell.backgroundColor = UIColor(named: "bg")
        let favoriet = FavorietenOptions(rawValue: indexPath.row)
        cell.sectionType = favoriet
        cell.sectionType2 = favoriet
        case .Verenigingen: cell.backgroundColor = UIColor(named: "bg")
        let vereniging = VerenigingenOptions(rawValue: indexPath.row)
        cell.sectionType = vereniging
        cell.sectionType2 = vereniging
        case .Overig: cell.backgroundColor = UIColor(named: "bg")
        let overig = OverigOptions(rawValue: indexPath.row)
        cell.sectionType = overig
        cell.sectionType2 = overig
//        let switcher = InstellingenCell.switchControl
//        cell.(switchControl).tag = indexPath.row
//        cell.accessoryType = .disclosureIndicator
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = SettingsSection(rawValue: section) else { return 0 }
        
        switch section {
        case .Favorieten: return 1
        case .Verenigingen: return 1
        case .Overig: return OverigOptions.allCases.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(named: "bg")
        
        let label = UILabel()
        label.text = SettingsSection(rawValue: section)?.description
        label.textColor = .mainOrange()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = SettingsSection(rawValue: indexPath.section) else { return }
        
        switch section {
        case .Favorieten:
            let favorieten = FavorietenOptions(rawValue: indexPath.row)
            let clickedItem = favorieten!.description
            if clickedItem == "Dash H1" {
                // true
            } else {
                // false
            }
        case .Verenigingen:
            let verenigingen = VerenigingenOptions(rawValue: indexPath.row)
            let clickedItem = verenigingen!.description
            if clickedItem == "Dash" {
                // true
            } else {
                // false
            }
        case .Overig:
            let overig = OverigOptions(rawValue: indexPath.row)
            let clickedItem = overig!.description
            if clickedItem == "Over deze app" {
                print("Over deze app is aangeklikt")
                let controller = OverDezeApp()
                let navigationController = UINavigationController(rootViewController: controller)
                navigationController.modalPresentationStyle = .fullScreen
                present(navigationController, animated: true)
            } else if clickedItem == "Hoe werkt de app?" {
                print("Hoe werkt de app is aangeklikt")
            } else if clickedItem == "Voeg hier uw team toe" {
                print("team toevoegen aangeklikt")
                let controller = TeamToevoegen()
                let navigationController = UINavigationController(rootViewController: controller)
                navigationController.modalPresentationStyle = .fullScreen
                present(navigationController, animated: true)
            } else {
                print("Een sukkel klikt op de readermodus balk")
            }
        }
    }

}
    
