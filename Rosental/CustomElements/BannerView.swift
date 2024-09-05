//
//  BannerView.swift
//  Rosental
//
//  Created by Артем Петрюк on 04.09.2024.
//

import UIKit
class BannerView: UIView {
    let banner: Banner
    
    let bannerImageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(banner: Banner) {
        
        self.banner = banner
        
        super.init(frame: .zero)
        configure()
    }
    
    func configure() {
        backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 5
        layer.masksToBounds = false
        layer.cornerRadius = 10
        
        addSubview(bannerImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        bannerImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        bannerImageView.kf.setImage(with: URL(string: banner.image))
        
        titleLabel.text = banner.title
        titleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        descriptionLabel.text = banner.text
        descriptionLabel.textColor = .gray
        descriptionLabel.font = .systemFont(ofSize: 12, weight: .medium)
        
        NSLayoutConstraint.activate([
            bannerImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            bannerImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            bannerImageView.heightAnchor.constraint(equalToConstant: 50),
            bannerImageView.widthAnchor.constraint(equalToConstant: 50),
            
            titleLabel.leadingAnchor.constraint(equalTo: bannerImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
        ])
    }
}
