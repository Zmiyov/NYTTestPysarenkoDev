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

    let mainVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .clear
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.contentMode = .center
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setConstraints()
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
        backgroundColor = .tertiarySystemBackground
    
        addSubview(mainVerticalStackView)
        mainVerticalStackView.addArrangedSubview(nameLabel)
        mainVerticalStackView.addArrangedSubview(publishedDateLabel)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            mainVerticalStackView.topAnchor.constraint(equalTo: topAnchor),
            mainVerticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainVerticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainVerticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
