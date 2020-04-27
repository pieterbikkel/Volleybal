//
//  InstelingenCell.swift
//  HamburgerMenu
//
//  Created by Pieter Bikkel on 10/04/2020.
//  Copyright © 2020 Pieter Bikkel. All rights reserved.
//

import UIKit

class InstellingenCell: UITableViewCell {
    
    // MARK: - Properties
    
    var sectionType: SectionType? {
        didSet {
            guard let sectionType = sectionType else { return }
            settingLabel.text = sectionType.description
            switchControl.isHidden = !sectionType.containsSwitch
        }
    }
    
    var sectionType2: SectionType2? {
        didSet {
            guard let sectionType2 = sectionType2 else { return }
            notificationButton.isHidden = !sectionType2.containsTeamOrClub
            deleteButton.isHidden = !sectionType2.containsTeamOrClub
        }
    }
    
    var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        button.tintColor = .mainOrange()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var notificationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bell.fill"), for: .normal)
        button.tintColor = .mainOrange()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.isOn = true
        switchControl.onTintColor = .mainOrange()
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        switchControl.addTarget(self, action: #selector(handleSwitchAction), for: .valueChanged)
        return switchControl
    }()
    
    var settingLabel: UILabel = {
        let label = UILabel()
        label.text = "Over deze app"
        label.font = label.font.withSize(14)
        return label
    }()
    
    fileprivate let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(named: "settingsCell")
        v.layer.cornerRadius = 10
        return v
    }()
    
    fileprivate lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [settingLabel, deleteButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        return stack
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        addSubview(container)
        container.addSubview(stack)
        
        setSwitchControlConstraints()
        setContainerConstraints()
        setNotificationButtonConstraints()
        setDeleteButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleSwitchAction(sender: UISwitch) {
        if sender .isOn {
            print("Turned on")
            let controller = NieuwsController()
            var read = controller.readermodus
            read = true
        } else {
            print("Turned off")
            let controller = NieuwsController()
            var read = controller.readermodus
            read = false
        }
    }
    
    // MARK: - Handlers
    
    func setDeleteButton() {
        container.addSubview(deleteButton)
        deleteButton.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 18).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 18).isActive = true
        deleteButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12).isActive = true
    }
    
    func setNotificationButtonConstraints() {
        container.addSubview(notificationButton)
        notificationButton.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        notificationButton.widthAnchor.constraint(equalToConstant: 18).isActive = true
        notificationButton.heightAnchor.constraint(equalToConstant: 18).isActive = true
        notificationButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -48).isActive = true
    }
    
    func setSwitchControlConstraints() {
        container.addSubview(switchControl)
        switchControl.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        switchControl.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12).isActive = true
    }
    
    func setContainerConstraints() {
        container.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7).isActive = true
        
        stack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12).isActive = true
        stack.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        stack.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.5).isActive = true
    }
    
}

/*
 TO DO:
 
 - SettingLabel uit de stackview halen en eigen constraints geven
 - DeleteButton en NotificationButton in stackView plaatsen
 - DeleteButton en NotificationButton van kleur veranderen wanneer erop geklikt is
 - DeleteButton en NotificationButton addtarget toevoegen voor beide, met tag wss
 - SwitchControl moet ook tag krijgen: https://www.youtube.com/watch?v=WqPoFzVrLj8
 - SwitchControl moet readermodus kunnen uitzetten
 - Hamburger menu vanaf elke optie uit het menu kunnen selecteren
 - Idee voor het dashboard scherm
 - launchscreen toevoegen
 - applogo toevoegen
 - AgendaController maken
 - StandController maken
 - UitslagenController maken
 - project beter organiseren met mapjes en met MARK
 - over deze app controller maken
 - hoe werkt de app controller maken
 - teamkiezer maken
 - dissappear statusbar issue kijken bij hamburgermenu
 - zorgen dat de gebruiker contact kan opnemen
 - zorgen dat de gebruiker suggesties kan voorstellen over de app
 - zorgen dat darkmode er overal goed uitziet
 - Nieuwsberichten redesign net zoals settings
 - Swipe van links opent hamburger menu en dissmissed de view
 
 */
