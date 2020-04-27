//
//  AgendaController.swift
//  HamburgerMenu
//
//  Created by Pieter Bikkel on 02/04/2020.
//  Copyright © 2020 Pieter Bikkel. All rights reserved.
//

import UIKit

class AgendaController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    
    struct NevoboNieuws: Hashable {
        var link: String
        var title: String
        var pubDate: String
        var description: String 
    }
    
    var favorietTeam: Bool = false
    
    struct Cells {
        static let agendaCell = "AgendaCell"
    }
    
    private let refreshControl = UIRefreshControl()
    
    var nieuwsTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    var username: String?
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
        //print(username!)
        
    }
    
    // MARK: - Selectors
    
    
    
    // MARK: - Helper Functions
    
    func configureTableView() {
        view.addSubview(nieuwsTableView)
        nieuwsTableView.register(AgendaCell.self, forCellReuseIdentifier: Cells.agendaCell)
        nieuwsTableView.delegate = self
        nieuwsTableView.dataSource = self
        nieuwsTableView.frame = view.frame
        nieuwsTableView.rowHeight = 180
        nieuwsTableView.separatorStyle = .none
        nieuwsTableView.backgroundColor = UIColor(named: "bg")
        
        if #available(iOS 10.0, *) {
            nieuwsTableView.refreshControl = refreshControl
        } else {
            nieuwsTableView.addSubview(refreshControl)
        }
        
        self.refreshControl.addTarget(self, action: #selector(refresher), for: .valueChanged)
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .mainOrange()
        navigationController?.navigationBar.barStyle = .black
        
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.mainOrange()]
        navigationItem.standardAppearance = appearance
        
        view.backgroundColor = UIColor(named: "bg")
        
        navigationItem.title = "Agenda"
    }
    
    func splitArray() -> [NevoboNieuws] {
        
        var ret = [NevoboNieuws]()
        let variable = AgendaParser()
        let feed = variable.loadData() as NSArray
        
        if let array = feed as? NSArray {
            for obj in array {
                if let dict = obj as? NSDictionary {
                    let link = dict.value(forKey: "link")
                    let title = dict.value(forKey: "title")
                    let pubDate = dict.value(forKey: "pubDate")
                    let description = dict.value(forKey: "description")
                    
                    let nieuws = NevoboNieuws(link: link as! String, title: title as! String, pubDate: pubDate as! String, description: description as! String)
                    
                    ret.append(nieuws)
                }
            }
        }
        
        return ret
    }
    
    @objc func refresher() {
        print("refresh")
        let variable = AgendaParser()
        let controller = UitslagenController()
        variable.loadRss(URL(string: "https://api.nevobo.nl/export/poule/\(controller.regio)/\(controller.poule)/stand.rss")!)
        nieuwsTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    // MARK: - TableView
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = nieuwsTableView.dequeueReusableCell(withIdentifier: Cells.agendaCell, for: indexPath) as! AgendaCell
        //let item = splitArray()[indexPath.row]
        //let title = item.title
        //let desc = item.description
        //let trimmedDesc = desc.trimmingCharacters(in: .whitespacesAndNewlines)
        //let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        cell.datumLabel.text = "Vrijdag 24 januari 2020"
        cell.locatieLabel.text = "’t Onderschoer, Barchem"
        cell.thuisTeamLabel.text = "BVC’73 HS 3"
        cell.uitTeamLabel.text = "Actief ’81 HS 1"
        cell.thuisTeamSetsLabel.text = "3"
        cell.uitTeamSetsLabel.text = "2"
        cell.tijdLabel.text = "17:30"
        cell.backgroundColor = UIColor(named: "bg")
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8                 //splitArray().count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

class AgendaParser {
    
    var myFeed : NSArray = []
    var feedImgs: [AnyObject] = []
    var url: URL!
    
    let controller = UitslagenController()
    
    func loadData() -> NSMutableArray {
        url = URL(string: "https://api.nevobo.nl/export/poule/\(controller.regio)/\(controller.poule)/stand.rss")!
        return loadRss(url)
    }
    
    func loadRss(_ data: URL) -> NSMutableArray {
        
        // XmlParserManager instance/object/variable.
        let myParser : AgendaXmlParserManager = AgendaXmlParserManager().initWithURL(data) as! AgendaXmlParserManager
        
        // Put feed in array.
        feedImgs = myParser.img as [AnyObject]
        myFeed = myParser.feeds
        
        return myFeed as! NSMutableArray
    }
    
}


extension UIColor {
    
    static func mainOrange() -> UIColor {
        return #colorLiteral(red: 0.9571682827, green: 0.3014328171, blue: 0.06929276344, alpha: 1)
    }
}


