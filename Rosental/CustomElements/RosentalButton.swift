//
//  RosentalButton.swift
//  Rosental
//
//  Created by Артем Петрюк on 01.09.2024.
//

import UIKit

class RosentalButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("I ❤️ storyboards")
    }
    
    init(backgroundColor: UIColor = UIColor(red: 0.96, green: 0.78, blue: 0.49, alpha: 1.00), title: String, hasOutline: Bool = false) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        if hasOutline {
            layer.borderWidth = 1
            layer.borderColor = CGColor(gray: 0.8, alpha: 1)
        }
        
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = 5
        setTitleColor(.black, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
    }
}
