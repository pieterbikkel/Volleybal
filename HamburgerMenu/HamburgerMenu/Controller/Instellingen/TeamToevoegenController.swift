//
//  TeamToevoegenController.swift
//  HamburgerMenu
//
//  Created by Pieter Bikkel on 20/04/2020.
//  Copyright © 2020 Pieter Bikkel. All rights reserved.
//

import UIKit

class TeamToevoegen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    
    
    var teamCell = "teamCell"
    
    
    var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    var petitions = [Petition]()
    
    var petitions2 = [Petitions]()
    
    let chevron = UIImage(systemName: "chevron.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .bold))?.withRenderingMode(.alwaysOriginal)
    lazy var changingChevron = chevron?.withTintColor(UIColor(named: "titleColor")!, renderingMode: .alwaysOriginal)
    
    // MARK: - Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureNavigationBar()
        jsonParser()
    }
    
    // MARK: - Handlers
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .mainOrange()
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.mainOrange()]
        navigationItem.standardAppearance = appearance
        
        view.backgroundColor = UIColor(named: "bg")
        navigationItem.title = "Team toevoegen"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: changingChevron, style: .plain, target: self, action: #selector(handleDismiss))
        
    }
    
    func jsonParser() {
        let urlString: String
        //https://www.volleybal.nl/xhr/search.json?q=DVO&type=competition&_=1587407420006
    
        urlString = "https://www.volleybal.nl/xhr/search.json?q=Dash&type=competition&_=1587407420006"
        

        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        showError()
        
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
                petitions = jsonPetitions.result
            if let jsonPetitions2 = try? decoder.decode(Petitions2, from: jsonPetitions) {
                petitions2 = jsonPetitions2.competition
            }
                tableView.reloadData()
        }
    }
    
    func showError() {
        let ac = UIAlertController(title: "Oeps", message: "Er is een probleem met het laden van de feed. Kijk of u verbonden bent met het internet en probeer opnieuw.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Oké", style: .default))
        present(ac, animated: true)
    }
    
    // MARK: - TableView
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.register(TeamCell.self, forCellReuseIdentifier: teamCell)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 46
        tableView.frame = view.frame
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(named: "bg")
        
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: teamCell, for: indexPath) as! TeamCell
        let petition = petitions[indexPath.row]
        print(petition.title)
        cell.textLabel?.text = petition.title
        //cell.backgroundColor = UIColor(named: "bg")
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
}
