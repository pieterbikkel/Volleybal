//
//  SettingsController.swift
//  HamburgerMenu
//
//  Created by Pieter Bikkel on 03/04/2020.
//  Copyright © 2020 Pieter Bikkel. All rights reserved.
//

import UIKit

class UitslagenController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties§
    
    struct NevoboUitslagen: Hashable {
        var titel: String
        var beschrijving: String
        var datum: String
    }
    
    var regio = "regio-west" // Kan bestaan uit: "regio-oost", "regio-west", "regio-noord" & "regio-zuid"
    var poule = "3AH" // Hier een aantal poulecodes om mee te testen voor regio-oost: "H2D", "D1G", "H2C" En poulecodes voor regio-west: "D1C", "3AH"
    
    struct UitslagenBeschrijving {
        var datum: String
        var locatie: String
    }
    
    var mijnItem: [UitslagenController.NevoboUitslagen] = []
    
    var limit = 20
    let totalEnteries = 128 //splitarray().count
    
    var favorietTeam: Bool = false
    
    struct Cells {
        static let uitslagenCell = "UitslagenCell"
    }
    
    private let refreshControl = UIRefreshControl()
    
    var uitslagenTableView: UITableView = {
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
        mijnItem = splitArray()
        
    }
    
    // MARK: - Selectors
    
    
    
    // MARK: - Helper Functions
    
    func configureTableView() {
        view.addSubview(uitslagenTableView)
        uitslagenTableView.register(UitslagenCell.self, forCellReuseIdentifier: Cells.uitslagenCell)
        uitslagenTableView.delegate = self
        uitslagenTableView.dataSource = self
        uitslagenTableView.frame = view.frame
        uitslagenTableView.rowHeight = 180
        uitslagenTableView.separatorStyle = .none
        uitslagenTableView.backgroundColor = UIColor(named: "bg")
        
        if #available(iOS 10.0, *) {
            uitslagenTableView.refreshControl = refreshControl
        } else {
            uitslagenTableView.addSubview(refreshControl)
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
        
        navigationItem.title = "Uitslagen"
    }
    
    func splitArray() -> [NevoboUitslagen] {
        print("cell geladen")
        var ret = [NevoboUitslagen]()
        let variable = UitslagenParser()
        let feed = variable.loadData() as NSArray
        if let array = feed as? NSArray {
            for obj in array {
                if let dict = obj as? NSDictionary {
                    let titel = dict.value(forKey: "title")
                    let beschrijving = dict.value(forKey: "description")
                    let datum = dict.value(forKey: "pubDate")
                    
                    let nieuws = NevoboUitslagen(titel: titel as! String, beschrijving: beschrijving as! String, datum: datum as! String)
                    ret.append(nieuws)
                }
            }
        }
        
        return ret
    }
    
    
    @objc func refresher() {
        print("refresh")
        let variable = UitslagenParser()
        variable.loadRss(URL(string: "https://api.nevobo.nl/export/poule/\(regio)/\(poule)/resultaten.rss")!)
        uitslagenTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    // MARK: - TableView
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = uitslagenTableView.dequeueReusableCell(withIdentifier: Cells.uitslagenCell, for: indexPath) as! UitslagenCell
        let item = mijnItem[indexPath.row]
        let datum = item.datum
        let trimmedDatum = datum.trimmingCharacters(in: .whitespacesAndNewlines)
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        let geformateerdeDatum = formatter.date(from: trimmedDatum)!
        formatter.dateFormat = .some("EEEE d MMMM yyyy")
        formatter.locale = Locale(identifier: "nl")
        let s = formatter.string(from: geformateerdeDatum)
        cell.datumLabel.text = s.capitalizingFirstLetter()
        
        let thuisTeam = item.beschrijving
        let trimmedThuisTeam = thuisTeam.trimmingCharacters(in: .whitespacesAndNewlines)
        
        var strArray = trimmedThuisTeam.components(separatedBy: " - ")
        if let range = strArray[0].range(of: "Wedstrijd: ") {
            strArray[0].removeSubrange(range)
        }
        if !strArray[0].hasPrefix("Vervallen wedstrijd: ") {
            //Uitslagen cell
            let teams = item.titel
            let beideTeams = teams.components(separatedBy: ": ")
            let haalUitslagWeg = beideTeams[0].components(separatedBy: ", ")
            let eenTeam = haalUitslagWeg[0].components(separatedBy: " - ")
            let totaalpunten = checkVijfdeSet(indexPath: indexPath)

            cell.locatieLabel.text = "geen locatie"
            cell.thuisTeamLabel.text = eenTeam[0]
            cell.uitTeamLabel.text = eenTeam[1]
            cell.thuisTeamPuntenLabel.text = "\(totaalpunten.0)"
            cell.uitTeamPuntenLabel.text = "\(totaalpunten.1)"
            cell.uitslagLabel.text = beideTeams[1]
            cell.totaalLabel.text = "Totaal"
            cell.backgroundColor = UIColor(named: "bg")
            cell.wedstrijdView.backgroundColor = UIColor(named: "settingsCell")
            
            return cell
        } else if strArray[0].hasPrefix("Vervallen wedstrijd: ") {
            //vervallen Wedstrijd Cell
            let teams = item.titel
            let beideTeams = teams.components(separatedBy: ": ")
            let eenTeam = beideTeams[2].components(separatedBy: " - ")
            
            cell.uitTeamPuntenLabel.backgroundColor = UIColor(named: "instellingenCell")
            cell.thuisTeamPuntenLabel.backgroundColor = UIColor(named: "instellingenCell")
            cell.locatieLabel.text = ""
            cell.thuisTeamLabel.text = eenTeam[0]
            cell.uitTeamLabel.text = eenTeam[1]
            cell.uitslagLabel.text = "17:30"
            cell.totaalLabel.text = "Wedstrijd Vervallen"
            cell.backgroundColor = UIColor(named: "bg")
            cell.wedstrijdView.backgroundColor = UIColor(named: "settingsCell")
            
            return cell
        } else {
            //uitgestelde Wedstrijd Cell
            print("uitgestelde wedstrijd")
            let teams = item.titel
            let beideTeams = teams.components(separatedBy: ": ")
            let eenTeam = beideTeams[1].components(separatedBy: " - ")
            
            cell.uitTeamPuntenLabel.backgroundColor = UIColor(named: "instellingenCell")
            cell.thuisTeamPuntenLabel.backgroundColor = UIColor(named: "instellingenCell")
            cell.locatieLabel.text = ""
            cell.thuisTeamLabel.text = eenTeam[0]
            cell.uitTeamLabel.text = eenTeam[1]
            cell.uitslagLabel.text = "17:30"
            cell.totaalLabel.text = "Wedstrijd uitgesteld"
            cell.backgroundColor = UIColor(named: "bg")
            cell.wedstrijdView.backgroundColor = UIColor(named: "settingsCell")
            
            return cell
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return splitArray().count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func checkVijfdeSet(indexPath: IndexPath) -> (Int, Int){
        let item = splitArray()[indexPath.row]
        let teams = item.titel
        let beideTeams = teams.components(separatedBy: ": ")
        
        let thuisTeam = item.beschrijving
        let trimmedThuisTeam = thuisTeam.trimmingCharacters(in: .whitespacesAndNewlines)
        let alleSetStanden = trimmedThuisTeam.components(separatedBy: "Setstanden: ")
        
        if beideTeams[1] == "3-2" || beideTeams[1] == "2-3" {
            let separateSets = alleSetStanden[1].components(separatedBy: ", ")
            let separateSet1 = separateSets[0].components(separatedBy: "-")
            let separateSet2 = separateSets[1].components(separatedBy: "-")
            let separateSet3 = separateSets[2].components(separatedBy: "-")
            let separateSet4 = separateSets[3].components(separatedBy: "-")
            let separateSet5 = separateSets[4].components(separatedBy: "-")
            
            let set1IntThuis = Int(separateSet1[0]) ?? 0
            let set2IntThuis = Int(separateSet2[0]) ?? 0
            let set3IntThuis = Int(separateSet3[0]) ?? 0
            let set4IntThuis = Int(separateSet4[0]) ?? 0
            let set5IntThuis = Int(separateSet5[0]) ?? 0
            let thuisTeampunten = set1IntThuis + set2IntThuis + set3IntThuis + set4IntThuis + set5IntThuis
            
            let set1IntUit = Int(separateSet1[1]) ?? 0
            let set2IntUit = Int(separateSet2[1]) ?? 0
            let set3IntUit = Int(separateSet3[1]) ?? 0
            let set4IntUit = Int(separateSet4[1]) ?? 0
            let set5IntUit = Int(separateSet5[1]) ?? 0
            let uitTeampunten = set1IntUit + set2IntUit + set3IntUit + set4IntUit + set5IntUit
            
            return (thuisTeampunten, uitTeampunten)
        } else {
            let separateSets = alleSetStanden[1].components(separatedBy: ", ")
            let separateSet1 = separateSets[0].components(separatedBy: "-")
            let separateSet2 = separateSets[1].components(separatedBy: "-")
            let separateSet3 = separateSets[2].components(separatedBy: "-")
            let separateSet4 = separateSets[3].components(separatedBy: "-")
            
            let set1IntThuis = Int(separateSet1[0]) ?? 0
            let set2IntThuis = Int(separateSet2[0]) ?? 0
            let set3IntThuis = Int(separateSet3[0]) ?? 0
            let set4IntThuis = Int(separateSet4[0]) ?? 0
            let thuisTeampunten = set1IntThuis + set2IntThuis + set3IntThuis + set4IntThuis
            
            let set1IntUit = Int(separateSet1[1]) ?? 0
            let set2IntUit = Int(separateSet2[1]) ?? 0
            let set3IntUit = Int(separateSet3[1]) ?? 0
            let set4IntUit = Int(separateSet4[1]) ?? 0
            let uitTeampunten = set1IntUit + set2IntUit + set3IntUit + set4IntUit
            
            return (thuisTeampunten, uitTeampunten)
        }
    }
    
}

class UitslagenParser {
    
    var myFeed : NSArray = []
    var feedImgs: [AnyObject] = []
    var url: URL!
    let controller = UitslagenController()
    
    func loadData() -> NSMutableArray {
        url = URL(string: "https://api.nevobo.nl/export/poule/\(controller.regio)/\(controller.poule)/resultaten.rss")!
        return loadRss(url)
    }
    
    func loadRss(_ data: URL) -> NSMutableArray {
        
        // XmlParserManager instance/object/variable.
        let myParser : UitslagenXmlParserManager = UitslagenXmlParserManager().initWithURL(data) as! UitslagenXmlParserManager
        
        // Put feed in array.
        feedImgs = myParser.img as [AnyObject]
        myFeed = myParser.feeds
        
        return myFeed as! NSMutableArray
    }
    
}


extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

