//
//  SettingsSection.swift
//  HamburgerMenu
//
//  Created by Pieter Bikkel on 10/04/2020.
//  Copyright © 2020 Pieter Bikkel. All rights reserved.
//

enum SettingsSection: Int, CaseIterable, CustomStringConvertible {
    case Favorieten
    case Verenigingen
    case Overig
    
    var description: String {
        switch self {
        case .Favorieten: return "Favorieten"
        case .Verenigingen: return "Verenigingen"
        case .Overig: return "Overig"
        }
    }
}
enum FavorietenOptions: Int, CaseIterable, SectionType, SectionType2{
    case team
    
    var containsTeamOrClub: Bool {
        switch self {
        case .team: return true
        }
    }
    
    var containsSwitch: Bool { return false }
    
    var description: String {
        switch self {
        case .team: return "Dash H1"
        }
    }
}

enum VerenigingenOptions: Int, CaseIterable, SectionType, SectionType2 {
    case vereniging
    
    var containsTeamOrClub: Bool {
        switch self {
        case .vereniging: return true
        }
    }
    
    var containsSwitch: Bool { return false }
    
    var description: String {
        switch self {
        case .vereniging: return "Dash"
        }
    }
}

enum OverigOptions: Int, CaseIterable, SectionType, SectionType2 {
    case appInfo
    case tutorial
    case newsReader
    case teamToevoegen
    
    var containsTeamOrClub: Bool { return false }
    
    var containsSwitch: Bool {
        switch self {
        case .appInfo: return false
        case .tutorial: return false
        case .newsReader: return true
        case .teamToevoegen: return false
        }
    }
    
    var description: String {
        switch self {
        case .appInfo: return "Over deze app"
        case .tutorial: return "Hoe werkt de app?"
        case .newsReader: return "Readermodus nieuwsartikelen"
        case .teamToevoegen: return "Voeg hier uw team toe"
        }
    }
}

