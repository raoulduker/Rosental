//
//  File.swift
//  Rosental
//
//  Created by Артем Петрюк on 04.09.2024.
//

import UIKit
class MenuItemView: UIView {
    let menuItem: MenuItem
    
    let menuLogoView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    let arrearLabel = UILabel()
    let indicatorStackView = UIStackView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(menuItem: MenuItem) {
        self.menuItem = menuItem
        
        super.init(frame: .zero)
        configure()
    }
    
    func configure() {
        addSubview(menuLogoView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(arrearLabel)
        
        menuLogoView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        arrearLabel.translatesAutoresizingMaskIntoConstraints = false
        
        menuLogoView.image = getMenuLogoImage(for: menuItem.action)
        
        titleLabel.text = menuItem.name
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        
        descriptionLabel.text = menuItem.description
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .medium)
        descriptionLabel.textColor = .gray
        
        NSLayoutConstraint.activate([
            menuLogoView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            menuLogoView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            menuLogoView.heightAnchor.constraint(equalToConstant: 40),
            menuLogoView.widthAnchor.constraint(equalToConstant: 40),
            
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: menuLogoView.trailingAnchor, constant: 15),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])
        
        if let arrear = menuItem.arrear {
            arrearLabel.text = arrear + " ₽"
            arrearLabel.textColor = .black
            arrearLabel.font = .systemFont(ofSize: 18, weight: .semibold)
            
            NSLayoutConstraint.activate([
                arrearLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                arrearLabel.topAnchor.constraint(equalTo: self.topAnchor)
                
            ])
        }
        
        if let indications = menuItem.expected?.indications {
            indicatorStackView.axis = .horizontal
            indicatorStackView.spacing = 7
            indicatorStackView.distribution = .fillEqually
            addSubview(indicatorStackView)
            indicatorStackView.translatesAutoresizingMaskIntoConstraints = false
            
            for indication in indications {
                let indicationImage = getIndicatonImage(indcation: indication)
                let indicationImageView = UIImageView(image: indicationImage)
                indicationImageView.tintColor = .black
                indicatorStackView.addArrangedSubview(indicationImageView)
                
                NSLayoutConstraint.activate([
                    indicatorStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                    indicatorStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 2)
                ])
                
            }
        }
    }
    
    func getIndicatonImage(indcation: Indication) -> UIImage {
        let configuration = UIImage.SymbolConfiguration(pointSize: 12, weight: .medium)
        switch indcation.type {
        case "electricity":
            return UIImage(systemName: "bolt.fill", withConfiguration: configuration)!
        case "water":
            return UIImage(systemName: "drop.fill", withConfiguration: configuration)!
        case "gas":
            return UIImage(systemName: "flame.fill", withConfiguration: configuration)!
        case "heating":
            return UIImage(systemName: "thermometer.snowflake", withConfiguration: configuration)!
        default:
            return UIImage()
        }
    }
    
    func getMenuLogoImage(for menuAction: String?) -> UIImage {
        switch menuAction {
        case "payment":
            UIImage(named: "payment")!
        case "meters":
            UIImage(named: "meters")!
        default:
            UIImage(named: "meters")!
        }
    }
}
