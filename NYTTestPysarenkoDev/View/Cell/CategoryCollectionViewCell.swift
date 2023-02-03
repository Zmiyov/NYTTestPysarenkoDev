//
//  CategoryCollectionViewCell.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 03.02.2023.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    
    let nameLabel = UILabel(font: UIFont.systemFont(ofSize: 24, weight: .bold), alighment: .left)
    let publishedDateLabel = UILabel(font: UIFont.systemFont(ofSize: 15, weight: .regular), alighment: .left)

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        
        layer.cornerRadius = 12
        backgroundColor = .white
        
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                                     nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
                                     nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
                                    ])
        
        addSubview(publishedDateLabel)
        publishedDateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                                     publishedDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
                                     publishedDateLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
                                    ])
        
    }
}
