//
//  AgendaCell.swift
//  HamburgerMenu
//
//  Created by Pieter Bikkel on 12/04/2020.
//  Copyright © 2020 Pieter Bikkel. All rights reserved.
//

import UIKit

class AgendaCell: UITableViewCell {
    
    // MARK: - Properties
    
    var datumLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "titleColor")
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    var locatieLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "titleColor")
        label.font = label.font.withSize(14)
        return label
    }()
    
    var wedstrijdView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let controller = AgendaController()
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
    
    var thuisTeamSetsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "titleColor")
        label.backgroundColor = UIColor(named: "bg")
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = label.font.withSize(14)
        return label
    }()
    
    var uitTeamSetsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "titleColor")
        label.backgroundColor = UIColor(named: "bg")
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = label.font.withSize(14)
        return label
    }()
    
    var tijdLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "titleColor")
        label.backgroundColor = UIColor(named: "bg")
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    var prognoseLabel: UILabel = {
        let label = UILabel()
        label.text = "Prognose"
        label.textColor = UIColor(named: "titleColor")
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    fileprivate lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [thuisTeamLabel, tijdLabel, uitTeamLabel])
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
        prognoseLabelConstraints()
        thuisTeamSetsLabelConstraints()
        uitTeamSetsLabelConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Constraints
    
    func thuisTeamSetsLabelConstraints() {
        wedstrijdView.addSubview(thuisTeamSetsLabel)
        thuisTeamSetsLabel.translatesAutoresizingMaskIntoConstraints = false
        thuisTeamSetsLabel.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 10).isActive = true
        thuisTeamSetsLabel.trailingAnchor.constraint(equalTo: thuisTeamLabel.trailingAnchor).isActive = true
        thuisTeamSetsLabel.widthAnchor.constraint(equalToConstant: 24).isActive = true
        thuisTeamSetsLabel.heightAnchor.constraint(equalTo: thuisTeamSetsLabel.widthAnchor).isActive = true
    }
    
    func uitTeamSetsLabelConstraints() {
        wedstrijdView.addSubview(uitTeamSetsLabel)
        uitTeamSetsLabel.translatesAutoresizingMaskIntoConstraints = false
        uitTeamSetsLabel.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 10).isActive = true
        uitTeamSetsLabel.leadingAnchor.constraint(equalTo: uitTeamLabel.leadingAnchor).isActive = true
        uitTeamSetsLabel.widthAnchor.constraint(equalToConstant: 24).isActive = true
        uitTeamSetsLabel.heightAnchor.constraint(equalTo: uitTeamSetsLabel.widthAnchor).isActive = true
    }
    
    func prognoseLabelConstraints() {
        wedstrijdView.addSubview(prognoseLabel)
        prognoseLabel.translatesAutoresizingMaskIntoConstraints = false
        prognoseLabel.centerXAnchor.constraint(equalTo: wedstrijdView.centerXAnchor).isActive = true
        prognoseLabel.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 12).isActive = true
    }
    
    func stackConstraints() {
        thuisTeamLabel.translatesAutoresizingMaskIntoConstraints = false
        thuisTeamLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        thuisTeamLabel.widthAnchor.constraint(equalToConstant: 105).isActive = true
        
        uitTeamLabel.translatesAutoresizingMaskIntoConstraints = false
        uitTeamLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        uitTeamLabel.widthAnchor.constraint(equalToConstant: 105).isActive = true
        
        tijdLabel.translatesAutoresizingMaskIntoConstraints = false
        tijdLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tijdLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        
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
