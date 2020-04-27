//
//  MenuOption.swift
//  HamburgerMenu
//
//  Created by Pieter Bikkel on 03/04/2020.
//  Copyright © 2020 Pieter Bikkel. All rights reserved.
//

import UIKit

enum MenuOption: Int, CustomStringConvertible {
    case Agenda
    case Stand
    case Uitslagen
    case Nieuws
    case Instellingen
    
    var description: String {
        switch self {
        case .Agenda: return "Agenda"
        case .Stand: return "Stand"
        case .Uitslagen: return "Uitslagen"
        case .Nieuws: return "Nieuws"
        case .Instellingen: return "Instellingen"
        }
    }

    var image: UIImage {
        switch self {
        case .Agenda: return UIImage(systemName: "calendar")!
        case .Stand: return UIImage(systemName: "list.number")!
        case .Uitslagen: return UIImage(systemName: "clock")!
        case .Nieuws: return UIImage(systemName: "doc.plaintext")!
        case .Instellingen: return UIImage(systemName: "gear")!
        }
    }
}


