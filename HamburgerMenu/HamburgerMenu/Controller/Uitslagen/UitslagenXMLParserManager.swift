//  credits to Arled Kola
//  XMLParserManager.swift
//  Volleybal
//
//  Created by Pieter Bikkel on 04/02/2020.
//  Copyright © 2020 Pieter Bikkel. All rights reserved.
//

import Foundation

class UitslagenXmlParserManager: NSObject, XMLParserDelegate {
    
    var parser = XMLParser()
    var feeds = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var titel = NSMutableString()
    var beschrijving = NSMutableString()
    var img:  [AnyObject] = []
    var datum = NSMutableString()
    
    var limit = 20
    let totalEnteries = 100
    
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
        if (element as NSString).isEqual(to: "item") {
            elements =  NSMutableDictionary()
            elements = [:]
            titel = NSMutableString()
            titel = ""
            beschrijving = NSMutableString()
            beschrijving = ""
            datum = NSMutableString()
            datum = ""
        } else if (element as NSString).isEqual(to: "enclosure") {
            if let urlString = attributeDict["url"] {
                img.append(urlString as AnyObject)
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if (elementName as NSString).isEqual(to: "item") {
            if titel != "" {
                elements.setObject(titel, forKey: "title" as NSCopying)
            }
            if beschrijving != "" {
                elements.setObject(beschrijving, forKey: "description" as NSCopying)
            }
            if datum != "" {
                elements.setObject(datum, forKey: "pubDate" as NSCopying)
            }
            feeds.add(elements)
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "title") {
            titel.append(string)
        } else if element.isEqual(to: "description") {
            beschrijving.append(string)
        } else if element.isEqual(to: "pubDate") {
            datum.append(string)
        }
    }
    
}

