//
//  UIView.swift
//  Rosental
//
//  Created by Артем Петрюк on 02.09.2024.
//

import UIKit

extension UIView {
    func setupView(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
    }
    
    func applyShadow(opacity: Float = 0.1, offset: CGSize = CGSize(width: 0, height: 1), radius: CGFloat = 5, color: UIColor = .black) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.masksToBounds = false
    }
}
