//
//  UitslagenCell.swift
//  HamburgerMenu
//
//  Created by Pieter Bikkel on 13/04/2020.
//  Copyright © 2020 Pieter Bikkel. All rights reserved.
//

import UIKit

class UitslagenCell: UITableViewCell {
    
    // MARK: - Properties
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thuisTeamSetsLabelConstraints()
        uitTeamPuntenLabelConstraints()
    }
    
    var datumLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainOrange()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    var locatieLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainOrange()
        label.font = label.font.withSize(14)
        return label
    }()
    
    var wedstrijdView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let controller = UitslagenController()
        if controller.favorietTeam == true {
            view.backgroundColor = .mainOrange()
        } else {
            view.backgroundColor = UIColor(named: "settingsCell")
        }
        view.layer.cornerRadius = 10
        return view
    }()
    
    var thuisTeamLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "titleColor")
        label.backgroundColor = UIColor(named: "bg")
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = label.font.withSize(12)
        label.numberOfLines = 2
        return label
    }()
    
    var uitTeamLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "titleColor")
        label.backgroundColor = UIColor(named: "bg")
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = label.font.withSize(12)
        label.numberOfLines = 2
        return label
    }()
    
    var thuisTeamPuntenLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "titleColor")
        label.backgroundColor = UIColor.mainOrange() //(named: "bg")
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = label.font.withSize(14)
        return label
    }()
    
    var uitTeamPuntenLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "titleColor")
        label.backgroundColor = UIColor.mainOrange() //(named: "bg")
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = label.font.withSize(14)
        return label
    }()
    
    var uitslagLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainOrange()
        label.backgroundColor = UIColor(named: "bg")
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    var totaalLabel: UILabel = {
        let label = UILabel()
        label.text = "Totaal"
        label.textColor = .mainOrange()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    fileprivate lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [thuisTeamLabel, uitslagLabel, uitTeamLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 12
        return stack
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        wedstrijdViewConstraints()
        datumLabelConstraints()
        locatieLabelConstraints()
        stackConstraints()
        totaalLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Constraints
    
    func thuisTeamSetsLabelConstraints() {
        wedstrijdView.addSubview(thuisTeamPuntenLabel)
        thuisTeamPuntenLabel.translatesAutoresizingMaskIntoConstraints = false
        thuisTeamPuntenLabel.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 10).isActive = true
        thuisTeamPuntenLabel.trailingAnchor.constraint(equalTo: thuisTeamLabel.trailingAnchor).isActive = true
        thuisTeamPuntenLabel.widthAnchor.constraint(equalToConstant: 72).isActive = true
        thuisTeamPuntenLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    func uitTeamPuntenLabelConstraints() {
        wedstrijdView.addSubview(uitTeamPuntenLabel)
        uitTeamPuntenLabel.translatesAutoresizingMaskIntoConstraints = false
        uitTeamPuntenLabel.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 10).isActive = true
        uitTeamPuntenLabel.leadingAnchor.constraint(equalTo: uitTeamLabel.leadingAnchor).isActive = true
        uitTeamPuntenLabel.widthAnchor.constraint(equalToConstant: 72).isActive = true
        uitTeamPuntenLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    func totaalLabelConstraints() {
        wedstrijdView.addSubview(totaalLabel)
        totaalLabel.translatesAutoresizingMaskIntoConstraints = false
        totaalLabel.centerXAnchor.constraint(equalTo: wedstrijdView.centerXAnchor).isActive = true
        totaalLabel.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 12).isActive = true
    }
    
    func stackConstraints() {
        thuisTeamLabel.translatesAutoresizingMaskIntoConstraints = false
        thuisTeamLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        thuisTeamLabel.widthAnchor.constraint(equalToConstant: 105).isActive = true
        
        uitTeamLabel.translatesAutoresizingMaskIntoConstraints = false
        uitTeamLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        uitTeamLabel.widthAnchor.constraint(equalToConstant: 105).isActive = true
        
        uitslagLabel.translatesAutoresizingMaskIntoConstraints = false
        uitslagLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        uitslagLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        
        wedstrijdView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.centerXAnchor.constraint(equalTo: wedstrijdView.centerXAnchor).isActive = true
        stack.topAnchor.constraint(equalTo: datumLabel.bottomAnchor, constant: 12).isActive = true
    }
    
    func locatieLabelConstraints() {
        wedstrijdView.addSubview(locatieLabel)
        locatieLabel.translatesAutoresizingMaskIntoConstraints = false
        locatieLabel.centerXAnchor.constraint(equalTo: wedstrijdView.centerXAnchor).isActive = true
        locatieLabel.bottomAnchor.constraint(equalTo: wedstrijdView.bottomAnchor, constant: -8).isActive  = true
    }
    
    func datumLabelConstraints() {
        wedstrijdView.addSubview(datumLabel)
        datumLabel.translatesAutoresizingMaskIntoConstraints = false
        datumLabel.centerXAnchor.constraint(equalTo: wedstrijdView.centerXAnchor).isActive = true
        datumLabel.topAnchor.constraint(equalTo: wedstrijdView.topAnchor, constant: 8).isActive  = true
    }
    
    func wedstrijdViewConstraints() {
        addSubview(wedstrijdView)
        wedstrijdView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        wedstrijdView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        wedstrijdView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.92).isActive = true
        wedstrijdView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.85).isActive = true
    }
    
}

