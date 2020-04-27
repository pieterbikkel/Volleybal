//
//  OverDezeAppSection.swift
//  HamburgerMenu
//
//  Created by Pieter Bikkel on 11/04/2020.
//  Copyright © 2020 Pieter Bikkel. All rights reserved.
//

enum OverDezeAppSection: Int, CaseIterable, CustomStringConvertible {
    case Feedback
    case Contact
    
    var description: String {
        switch self {
        case .Feedback: return "Feedback"
        case .Contact: return "Contact"
        }
    }
}


enum FeedbackOptions: Int, CaseIterable, CustomStringConvertible {
    case feedback
    
    var description: String {
        switch self {
        case .feedback: return "Suggesties voor een betere app"
        }
    }
}

enum ContactOptions: Int, CaseIterable, CustomStringConvertible {
    case contact
    
    var description: String {
        switch self {
        case .contact: return "Neem contact op"
        }
    }
}


