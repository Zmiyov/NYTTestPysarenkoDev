//
//  BookCollectionViewCell.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 03.02.2023.
//

import UIKit
import WebKit

final class BookCollectionViewCell: UICollectionViewCell {
    
    let bookNameLabel = UILabel(font: UIFont.systemFont(ofSize: 24, weight: .bold), alighment: .left)
    let descriptionLabel = UILabel(font: UIFont.systemFont(ofSize: 15, weight: .regular), alighment: .left)
    let authorLabel = UILabel(font: UIFont.systemFont(ofSize: 15, weight: .regular), alighment: .left)
    let publisherLabel = UILabel(font: UIFont.systemFont(ofSize: 15, weight: .regular), alighment: .left)
    let rankLabel = UILabel(font: UIFont.systemFont(ofSize: 15, weight: .regular), alighment: .left)

    private let buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Buy", for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 21)
        button.backgroundColor = .link
        button.contentHorizontalAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupButton() {
        buyButton.addTarget(self, action: #selector(openBuyLink), for: .touchUpInside)
    }
    
    @objc func openBuyLink() {
        print("Perform")
        
        guard let url = URL(string: "https://stackoverflow.com") else { return }
        let webView = WebViewViewController(url: url, title: "Buy Book")
        let navVC = UINavigationController(rootViewController: webView)
        self.window?.rootViewController?.present(navVC, animated: true)
    }
    
    private func setupView() {
        
        layer.cornerRadius = 12
        backgroundColor = .white
        
        addSubview(bookNameLabel)
        bookNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([bookNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                                     bookNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15)
                                    ])
        
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                                     descriptionLabel.topAnchor.constraint(equalTo: bookNameLabel.bottomAnchor, constant: 10)
                                    ])
        addSubview(buyButton)
        NSLayoutConstraint.activate([
            buyButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            buyButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            buyButton.widthAnchor.constraint(equalToConstant: 100),
            buyButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
}
