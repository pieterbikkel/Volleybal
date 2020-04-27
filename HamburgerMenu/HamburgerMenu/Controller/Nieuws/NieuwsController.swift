//
//  SettingsController.swift
//  HamburgerMenu
//
//  Created by Pieter Bikkel on 03/04/2020.
//  Copyright © 2020 Pieter Bikkel. All rights reserved.
//

import UIKit
import SafariServices

class NieuwsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    
    struct NevoboNieuws: Hashable {
      var link: String
      var title: String
      var pubDate: String
      var description: String
    }
    
    var readermodus: Bool = true
    
    struct Cells {
        static let NieuwsCell = "NieuwsCell"
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
        nieuwsTableView.register(NieuwsCell.self, forCellReuseIdentifier: Cells.NieuwsCell)
        nieuwsTableView.delegate = self
        nieuwsTableView.dataSource = self
        nieuwsTableView.frame = view.frame
        nieuwsTableView.rowHeight = 150
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
        
        navigationItem.title = "Nieuws"
    }
    
    func splitArray() -> [NevoboNieuws] {
        
        var ret = [NevoboNieuws]()
        let variable = NieuwsParser()
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
        let variable = NieuwsParser()
        variable.loadRss(URL(string: "https://api.nevobo.nl/export/nieuws.rss")!)
        nieuwsTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    // MARK: - TableView
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = nieuwsTableView.dequeueReusableCell(withIdentifier: Cells.NieuwsCell, for: indexPath) as! NieuwsCell
        let item = splitArray()[indexPath.row]
        let title = item.title
        let desc = item.description
        let trimmedDesc = desc.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        cell.NieuwsTitleLabel.text = trimmedTitle
        cell.NieuwsDescriptionLabel.text = trimmedDesc
        cell.backgroundColor = UIColor(named: "bg")
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return splitArray().count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = splitArray()[indexPath.row]
        let link = item.link
        let trimmedLink = link.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = readermodus
        
        let detailController = SFSafariViewController(url: URL(string: trimmedLink)!, configuration: config)
        present(detailController, animated: true)
    }

}

class NieuwsParser {
    
    var myFeed : NSArray = []
    var feedImgs: [AnyObject] = []
    var url: URL!
    
    
    func loadData() -> NSMutableArray {
        url = URL(string: "https://api.nevobo.nl/export/nieuws.rss")!
        return loadRss(url)
    }
    
    func loadRss(_ data: URL) -> NSMutableArray {
        
        // XmlParserManager instance/object/variable.
        let myParser : NieuwsXmlParserManager = NieuwsXmlParserManager().initWithURL(data) as! NieuwsXmlParserManager
        
        // Put feed in array.
        feedImgs = myParser.img as [AnyObject]
        myFeed = myParser.feeds
        
        return myFeed as! NSMutableArray
    }
    
}

extension TimeInterval {
    func asTimeString() -> String {
        let hours = Int(self) / 3600
        let minutes = Int(self) / 60
        let seconds = Int(self) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
}
