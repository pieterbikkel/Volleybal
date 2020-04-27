//
//  OverDezeApp.swift
//  HamburgerMenu
//
//  Created by Pieter Bikkel on 11/04/2020.
//  Copyright © 2020 Pieter Bikkel. All rights reserved.
//

import UIKit

class OverDezeApp: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    
    var infoSectionHeader: UILabel = {
        let label = UILabel()
        label.text = "Info"
        label.textColor = .mainOrange()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    struct Cells {
        static let OverDezeAppCell = "OverDezeAppCell"
    }
    
    private let refreshControl = UIRefreshControl()
    
    var instellingenTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    fileprivate let bigContainer: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(named: "settingsCell")
        v.layer.cornerRadius = 10
        return v
    }()

    var username: String?
    
    let chevron = UIImage(systemName: "chevron.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .bold))?.withRenderingMode(.alwaysOriginal)
    lazy var changingChevron = chevron?.withTintColor(UIColor(named: "titleColor")!, renderingMode: .alwaysOriginal)
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureInfoView()
        configureTableView()
        tableviewConstraints()
        setInfoSectionHeaderConstraints()
        
    }
    
    // MARK: - Selectors
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helper Functions
    
    func setInfoSectionHeaderConstraints() {
        view.addSubview(infoSectionHeader)
        infoSectionHeader.translatesAutoresizingMaskIntoConstraints = false
        infoSectionHeader.bottomAnchor.constraint(equalTo: bigContainer.topAnchor, constant: -12).isActive = true
        infoSectionHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoSectionHeader.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func configureTableView() {
        view.addSubview(instellingenTableView)
        instellingenTableView.register(OverDezeAppCell.self, forCellReuseIdentifier: Cells.OverDezeAppCell)
        instellingenTableView.delegate = self
        instellingenTableView.dataSource = self
        instellingenTableView.translatesAutoresizingMaskIntoConstraints = false
        instellingenTableView.rowHeight = 60
        instellingenTableView.separatorStyle = .none
        instellingenTableView.backgroundColor = UIColor(named: "bg")
        instellingenTableView.alwaysBounceVertical = false
    }
    
    func tableviewConstraints() {
        instellingenTableView.topAnchor.constraint(equalTo: bigContainer.bottomAnchor).isActive = true
        instellingenTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        instellingenTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive  = true
        instellingenTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func configureInfoView() {
        let functie = configureNavigationBar()
        view.addSubview(bigContainer)
        bigContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bigContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: functie + 130).isActive = true
        bigContainer.heightAnchor.constraint(equalToConstant: 100).isActive = true
        bigContainer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    }

    func configureNavigationBar() -> CGFloat {
        navigationController?.navigationBar.barTintColor = .mainOrange()
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.mainOrange()]
        navigationItem.standardAppearance = appearance
        
        let navigationBarHeight = self.navigationController?.navigationBar.frame.height ?? 0
        
        view.backgroundColor = UIColor(named: "bg")
        navigationItem.title = "Over deze app"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: changingChevron, style: .plain, target: self, action: #selector(handleDismiss))
        
        return navigationBarHeight
    }
    
    // MARK: - Tableview
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = instellingenTableView.dequeueReusableCell(withIdentifier: Cells.OverDezeAppCell, for: indexPath) as! OverDezeAppCell
        
        guard let section = OverDezeAppSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .Feedback:
            cell.backgroundColor = UIColor(named: "bg")
            let feedback = FeedbackOptions(rawValue: indexPath.row)
            cell.settingLabel.text = feedback?.description
        case .Contact:
            cell.backgroundColor = UIColor(named: "bg")
            let contact = ContactOptions(rawValue: indexPath.row)
            cell.settingLabel.text = contact?.description
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = OverDezeAppSection(rawValue: section) else { return 0 }
        
        switch section {
        case .Feedback: return FeedbackOptions.allCases.count
        case .Contact: return ContactOptions.allCases.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return OverDezeAppSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(named: "bg")
        
        let label = UILabel()
        label.text = OverDezeAppSection(rawValue: section)?.description
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
        guard let section = OverDezeAppSection(rawValue: indexPath.section) else { return }
        
        switch section {
        case .Feedback:
            print("Feedback optie is aangeklikt")
        case .Contact:
            print("Contact opnemen is aangeklikt")
        }
    }

}
    
