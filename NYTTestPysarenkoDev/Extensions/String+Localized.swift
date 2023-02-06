//
//  String+Localized.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 07.02.2023.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
