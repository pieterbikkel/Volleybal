//  credits to Arled Kola
//  XMLParserManager.swift
//  Volleybal
//
//  Created by Pieter Bikkel on 04/02/2020.
//  Copyright © 2020 Pieter Bikkel. All rights reserved.
//

import Foundation

class AgendaXmlParserManager: NSObject, XMLParserDelegate {
    
    var parser = XMLParser()
    var feeds = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var ftitle = NSMutableString()
    var link = NSMutableString()
    var img:  [AnyObject] = []
    var fdescription = NSMutableString()
    var fdate = NSMutableString()
    
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
            ftitle = NSMutableString()
            ftitle = ""
            link = NSMutableString()
            link = ""
            fdescription = NSMutableString()
            fdescription = ""
            fdate = NSMutableString()
            fdate = ""
        } else if (element as NSString).isEqual(to: "enclosure") {
            if let urlString = attributeDict["url"] {
                img.append(urlString as AnyObject)
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if (elementName as NSString).isEqual(to: "stand:ranking") {
            if ftitle != "" {
                elements.setObject(ftitle, forKey: "stand:nummer" as NSCopying)
            }
            if link != "" {
                elements.setObject(link, forKey: "stand:wedstrijden" as NSCopying)
            }
            if fdescription != "" {
                elements.setObject(fdescription, forKey: "stand:punten" as NSCopying)
            }
            if fdate != "" {
                elements.setObject(fdate, forKey: "description" as NSCopying)
            }
            feeds.add(elements)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "stand:nummer") {
            ftitle.append(string)
        } else if element.isEqual(to: "stand:wedstrijden") {
            link.append(string)
        } else if element.isEqual(to: "stand:punten") {
            fdescription.append(string)
        } else if element.isEqual(to: "description") {
            fdate.append(string)
        }
    }
    
    struct NieuwsData: Identifiable {
        var id = UUID()
        var title: String
        var desc: String
        var article: String
    }
}

