//
//  CategoryCollectionViewCell.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 03.02.2023.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    
    let nameLabel = UILabel(font: UIFont.systemFont(ofSize: 17, weight: .bold), alighment: .center)
    let publishedDateLabel = UILabel(font: UIFont.systemFont(ofSize: 15, weight: .regular), alighment: .center)

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSubviews() {
        if UIDevice.current.orientation.isLandscape {
            nameLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
            publishedDateLabel.font = UIFont.systemFont(ofSize: 23, weight: .regular)
        } else {
            nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            publishedDateLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        }
    }
    
    private func setupView() {
        
        layer.cornerRadius = 12
        backgroundColor = .white
        
        let mainVerticalStackView = UIStackView()
        mainVerticalStackView.axis = .vertical
        mainVerticalStackView.backgroundColor = .clear
        mainVerticalStackView.distribution = .fillEqually
//        mainVerticalStackView.
        mainVerticalStackView.spacing = 5
        mainVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        mainVerticalStackView.contentMode = .center
        
        addSubview(mainVerticalStackView)
        NSLayoutConstraint.activate([
            mainVerticalStackView.topAnchor.constraint(equalTo: topAnchor),
            mainVerticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainVerticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainVerticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
//            mainVerticalStackView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
        
        mainVerticalStackView.addArrangedSubview(nameLabel)
//        nameLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//                                     nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
//                                     nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
//                                    ])
        
        mainVerticalStackView.addArrangedSubview(publishedDateLabel)
//        publishedDateLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//                                     publishedDateLabel.bottomAnchor.constraint(equalTo: mainVerticalStackView.bottomAnchor, constant: 0)
//
//                                    ])
        
    }
}
