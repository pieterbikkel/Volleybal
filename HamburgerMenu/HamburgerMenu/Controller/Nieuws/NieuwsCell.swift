//
//  NieuwsCell.swift
//  HamburgerMenu
//
//  Created by Pieter Bikkel on 10/04/2020.
//  Copyright © 2020 Pieter Bikkel. All rights reserved.
//

import UIKit

class NieuwsCell: UITableViewCell {
    
    var NieuwsTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainOrange()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    var NieuwsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "descText")
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.adjustsFontSizeToFitWidth = false
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(named: "settingsCell")
        v.layer.cornerRadius = 10
        return v
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        setContainerConstraints()
        setNieuwsTitleLabelConstraints()
        setNieuwsDescriptionLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNieuwsTitleLabelConstraints() {
        addSubview(NieuwsTitleLabel)
        NieuwsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NieuwsTitleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8).isActive = true
        NieuwsTitleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8).isActive = true
        NieuwsTitleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 5).isActive = true
    }
    
    func setNieuwsDescriptionLabelConstraints() {
        addSubview(NieuwsDescriptionLabel)
        NieuwsDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NieuwsDescriptionLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8).isActive = true
        NieuwsDescriptionLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8).isActive = true
        NieuwsDescriptionLabel.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 8).isActive = true
        NieuwsDescriptionLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -5).isActive = true
        NieuwsDescriptionLabel.heightAnchor.constraint(equalToConstant: 75).isActive = true
    }
    
    func setContainerConstraints() {
        addSubview(container)
        container.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.92).isActive = true
        container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.85).isActive = true
    }
    
}
