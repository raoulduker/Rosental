//
//  ServiceCardView.swift
//  Rosental
//
//  Created by Артем Петрюк on 04.09.2024.
//

import UIKit
class ServiceCardView: UIView {
    let service: Service
    let imageView = UIImageView()
    let label = UILabel()
    
    init(service: Service) {
        self.service = service
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.97, alpha: 1.00)
        imageView.image = getServiceImage(for: service.action)
        imageView.contentMode = .scaleAspectFit
        setupView(imageView)
        
        label.text = service.name
        label.font = .systemFont(ofSize: 12, weight: .bold)
        setupView(label)
        
        layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 40),
            imageView.widthAnchor.constraint(equalToConstant: 40),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    func getServiceImage(for serviceAction: String) -> UIImage {
        switch serviceAction {
        case "docs":
            return UIImage(systemName: "doc.text")!
        case "offer":
            return UIImage(named: "offer")!
        case "poll":
            return UIImage(systemName: "checklist")!
        case "cleaning":
            return UIImage(systemName: "broom")!
        case "basip":
            return UIImage(systemName: "lock.shield")!
        case "vote":
            return UIImage(systemName: "hand.raised.fill")!
        case "pass":
            return UIImage(systemName: "person.badge.plus")!
        default:
            return UIImage(systemName: "questionmark.circle")!
        }
    }
}
