//
//  Protocols.swift
//  HamburgerMenu
//
//  Created by Pieter Bikkel on 02/04/2020.
//  Copyright © 2020 Pieter Bikkel. All rights reserved.
//

protocol SectionType: CustomStringConvertible {
    var containsSwitch: Bool { get }
}

protocol SectionType2 {
    var containsTeamOrClub: Bool { get }
}

