//
//  StandCell.swift
//  HamburgerMenu
//
//  Created by Pieter Bikkel on 12/04/2020.
//  Copyright © 2020 Pieter Bikkel. All rights reserved.
//

import UIKit

class StandCell: UITableViewCell {
    
    // MARK: - Properties
    
    var nummerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainOrange()//UIColor(named: "titleColor")
        label.backgroundColor = UIColor(named: "settingsCell")
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    var teamLabel: UILabel = {
        let label = PaddingLabel()
        label.textColor = UIColor(named: "titleColor")
        label.backgroundColor = UIColor(named: "settingsCell")
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.font = label.font.withSize(14)
        return label
    }()
    
    var wedstrijdenLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainOrange()//UIColor(named: "titleColor")
        label.backgroundColor = UIColor(named: "settingsCell")
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    var puntenLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainOrange()//UIColor(named: "titleColor")
        label.backgroundColor = UIColor(named: "settingsCell")
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    fileprivate lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nummerLabel, teamLabel, wedstrijdenLabel, puntenLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 3
        return stack
    }()
    
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        stackConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Constraints
    
    func stackConstraints() {
        addSubview(stack)
        stack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        nummerLabel.translatesAutoresizingMaskIntoConstraints = false
        nummerLabel.widthAnchor.constraint(equalToConstant: 42).isActive = true
        nummerLabel.heightAnchor.constraint(equalTo: nummerLabel.widthAnchor).isActive = true
        
        teamLabel.translatesAutoresizingMaskIntoConstraints = false
        teamLabel.widthAnchor.constraint(equalToConstant: 235).isActive = true
        
        wedstrijdenLabel.translatesAutoresizingMaskIntoConstraints = false
        wedstrijdenLabel.widthAnchor.constraint(equalToConstant: 42).isActive = true
        wedstrijdenLabel.heightAnchor.constraint(equalTo: wedstrijdenLabel.widthAnchor).isActive = true
        
        puntenLabel.translatesAutoresizingMaskIntoConstraints = false
        puntenLabel.widthAnchor.constraint(equalToConstant: 42).isActive = true
        puntenLabel.heightAnchor.constraint(equalTo: puntenLabel.widthAnchor).isActive = true
    }
    
}


@IBDesignable class PaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 0
    @IBInspectable var bottomInset: CGFloat = 0
    @IBInspectable var leftInset: CGFloat = 8.0
    @IBInspectable var rightInset: CGFloat = 8.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
