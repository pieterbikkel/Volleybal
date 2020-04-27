//
//  SettingsController.swift
//  HamburgerMenu
//
//  Created by Pieter Bikkel on 03/04/2020.
//  Copyright © 2020 Pieter Bikkel. All rights reserved.
//

import UIKit

class StandController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    
    struct NevoboStand: Hashable {
        var nummer: String
        var punten: String
        var team: String
        var wedstrijden: String
    }
    
    struct NevoboKlasse: Hashable {
        var klasse: String
    }
    
    struct Cells {
        static let standCell = "StandCell"
    }
    
    private let refreshControl = UIRefreshControl()
    
    fileprivate let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(named: "settingsCell")
        v.layer.cornerRadius = 10
        return v
    }()
    
    var standTableView: UITableView = {
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
        view.addSubview(standTableView)
        standTableView.register(StandCell.self, forCellReuseIdentifier: Cells.standCell)
        standTableView.delegate = self
        standTableView.dataSource = self
        standTableView.rowHeight = 46
        standTableView.frame = view.frame
        standTableView.separatorStyle = .none
        standTableView.backgroundColor = UIColor(named: "bg")
        
        if #available(iOS 10.0, *) {
            standTableView.refreshControl = refreshControl
        } else {
            standTableView.addSubview(refreshControl)
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
        
        navigationItem.title = "Stand"
    }
    
    func splitArray() -> [NevoboStand] {
        
        var ret = [NevoboStand]()
        let variable = StandParser()
        let feed = variable.loadData() as NSArray
        
        if let array = feed as? NSArray {
            for obj in array {
                if let dict = obj as? NSDictionary {
                    let nummer = dict.value(forKey: "stand:nummer")
                    let team = dict.value(forKey: "stand:team")
                    let punten = dict.value(forKey: "stand:punten")
                    let wedstrijden = dict.value(forKey: "stand:wedstrijden")
                    
                    let nieuws = NevoboStand(nummer: nummer as! String, punten: punten as! String, team: team as! String, wedstrijden: wedstrijden as! String)
                    
                    ret.append(nieuws)
                }
            }
        }
        
        return ret
    }
    
    func splitKlasseArray() -> [NevoboKlasse] {
        
        var ret = [NevoboKlasse]()
        let variable = KlasseParser()
        let feed = variable.loadData() as NSArray
        print(feed)
        if let array = feed as? NSArray {
            for obj in array {
                if let dict = obj as? NSDictionary {
                    let klasse = dict.value(forKey: "title")
                    
                    let nieuws = NevoboKlasse(klasse: klasse as! String)
                    ret.append(nieuws)
                }
            }
        }
        
        return ret
    }
    
    @objc func refresher() {
        print("refresh")
        let variable = StandParser()
        let controller = UitslagenController()
        variable.loadRss(URL(string: "https://api.nevobo.nl/export/poule/\(controller.regio)/\(controller.poule)/stand.rss")!)
        standTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    // MARK: - TableView
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = standTableView.dequeueReusableCell(withIdentifier: Cells.standCell, for: indexPath) as! StandCell
        let item = splitArray()[indexPath.row]
        cell.nummerLabel.text = item.nummer
        cell.teamLabel.text = item.team
        cell.wedstrijdenLabel.text = item.wedstrijden
        cell.puntenLabel.text = item.punten
        //let punten = item.punten
        //let desc = item.wedstrijden
        //let trimmedDesc = desc.trimmingCharacters(in: .whitespacesAndNewlines)
        //let trimmedpunten = punten.trimmingCharacters(in: .whitespacesAndNewlines)
        cell.backgroundColor = UIColor(named: "bg")
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return splitArray().count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(named: "settingsCell")
        view.layer.cornerRadius = 10
        
        let data: [NevoboKlasse] = splitKlasseArray()
        print(data[0].klasse)
        var titel = data[0].klasse
        if let range = titel.range(of: "Stand ") {
           titel.removeSubrange(range)
        }
        if let regioBullshit = titel.range(of: " Regio Oost") {
            titel.removeSubrange(regioBullshit)
        } else if let regioBullshit = titel.range(of: " Regio West") {
            titel.removeSubrange(regioBullshit)
        } else if let regioBullshit = titel.range(of: " Regio Zuid") {
            titel.removeSubrange(regioBullshit)
        } else if let regioBullshit = titel.range(of: " Regio Noord") {
            titel.removeSubrange(regioBullshit)
        }
        let klasseLabel = UILabel()
        klasseLabel.text = titel
        klasseLabel.textColor = .mainOrange()
        klasseLabel.font = UIFont.boldSystemFont(ofSize: 14)
        
        let wedLabel = UILabel()
        wedLabel.text = "WED"
        wedLabel.textColor = .mainOrange()
        wedLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        let pntLabel = UILabel()
        pntLabel.text = "PNT"
        pntLabel.textColor = .mainOrange()
        pntLabel.font = UIFont.boldSystemFont(ofSize: 16)
    
        view.addSubview(klasseLabel)
        view.addSubview(wedLabel)
        view.addSubview(pntLabel)
        
        klasseLabel.translatesAutoresizingMaskIntoConstraints = false
        klasseLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        klasseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        
        wedLabel.translatesAutoresizingMaskIntoConstraints = false
        wedLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        wedLabel.trailingAnchor.constraint(equalTo: pntLabel.leadingAnchor, constant: -10).isActive = true
        
        pntLabel.translatesAutoresizingMaskIntoConstraints = false
        pntLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        pntLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 3).isActive = true
        view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 3).isActive = true
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 42
    }
    
}

class StandParser {
    
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
        let myParser : StandXmlParserManager = StandXmlParserManager().initWithURL(data) as! StandXmlParserManager
        
        // Put feed in array.
        feedImgs = myParser.img as [AnyObject]
        myFeed = myParser.feeds
        
        return myFeed as! NSMutableArray
    }
    
}


class KlasseParser {
    
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
        let myParser : KlasseXmlParserManager = KlasseXmlParserManager().initWithURL(data) as! KlasseXmlParserManager
        
        // Put feed in array.
        feedImgs = myParser.img as [AnyObject]
        myFeed = myParser.feeds
        
        return myFeed as! NSMutableArray
    }
    
}
