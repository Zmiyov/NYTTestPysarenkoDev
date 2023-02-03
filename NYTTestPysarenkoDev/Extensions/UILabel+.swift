//
//  UILabel+.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 03.02.2023.
//

import UIKit

extension UILabel {
    convenience init(font: UIFont?, alighment: NSTextAlignment) {
        self.init()
        self.font = font
        self.textAlignment = alighment
        self.textColor = .label
        self.backgroundColor = .clear
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(text: String, font: UIFont?, alighment: NSTextAlignment) {
        self.init()
        self.text = text
        self.font = font
        self.textAlignment = alighment
        self.textColor = .label
        self.backgroundColor = .clear
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
