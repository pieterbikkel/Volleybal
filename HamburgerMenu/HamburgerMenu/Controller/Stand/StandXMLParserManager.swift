//  credits to Arled Kola
//  XMLParserManager.swift
//  Volleybal
//
//  Created by Pieter Bikkel on 04/02/2020.
//  Copyright © 2020 Pieter Bikkel. All rights reserved.
//

import Foundation

class StandXmlParserManager: NSObject, XMLParserDelegate {
    
    var parser = XMLParser()
    var feeds = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var standnummer = NSMutableString()
    var aantalwedstrijden = NSMutableString()
    var img:  [AnyObject] = []
    var aantalpunten = NSMutableString()
    var beschrijving = NSMutableString()
    
    // initilise parser
    func initWithURL(_ url :URL) -> AnyObject {
        startParse(url)
        return self
    }
    
    func startParse(_ url :URL) {
        feeds = []
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        parser.shouldProcessNamespaces = false
        parser.shouldReportNamespacePrefixes = false
        parser.shouldResolveExternalEntities = false
        parser.parse()
    }
    
    func allFeeds() -> NSMutableArray {
        return feeds
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element = elementName as NSString
        if (element as NSString).isEqual(to: "stand:ranking") {
            elements =  NSMutableDictionary()
            elements = [:]
            standnummer = NSMutableString()
            standnummer = ""
            aantalwedstrijden = NSMutableString()
            aantalwedstrijden = ""
            aantalpunten = NSMutableString()
            aantalpunten = ""
            beschrijving = NSMutableString()
            beschrijving = ""
        } else if (element as NSString).isEqual(to: "enclosure") {
            if let urlString = attributeDict["url"] {
                img.append(urlString as AnyObject)
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if (elementName as NSString).isEqual(to: "stand:ranking") {
            if standnummer != "" {
                elements.setObject(standnummer, forKey: "stand:nummer" as NSCopying)
            }
            if aantalwedstrijden != "" {
                elements.setObject(aantalwedstrijden, forKey: "stand:wedstrijden" as NSCopying)
            }
            if aantalpunten != "" {
                elements.setObject(aantalpunten, forKey: "stand:punten" as NSCopying)
            }
            if beschrijving != "" {
                elements.setObject(beschrijving, forKey: "stand:team" as NSCopying)
            }
            feeds.add(elements)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "stand:nummer") {
            standnummer.append(string)
        } else if element.isEqual(to: "stand:wedstrijden") {
            aantalwedstrijden.append(string)
        } else if element.isEqual(to: "stand:punten") {
            aantalpunten.append(string)
        } else if element.isEqual(to: "stand:team") {
            beschrijving.append(string)
        }
    }
    
}

