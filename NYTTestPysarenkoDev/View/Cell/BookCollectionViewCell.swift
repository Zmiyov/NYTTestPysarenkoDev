//
//  BookCollectionViewCell.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 03.02.2023.
//

import UIKit
import WebKit
import SafariServices

final class BookCollectionViewCell: UICollectionViewCell {
    
    var urlString: String?
    var imageURL: String?
    
    let bookNameLabel = UILabel(font: UIFont.systemFont(ofSize: 17, weight: .bold), alighment: .left)
    let descriptionLabel = UILabel(font: UIFont.systemFont(ofSize: 15, weight: .regular), alighment: .left)
    let authorLabel = UILabel(font: UIFont.systemFont(ofSize: 15, weight: .regular), alighment: .left)
    let publisherLabel = UILabel(font: UIFont.systemFont(ofSize: 15, weight: .regular), alighment: .left)
    let rankLabel = UILabel(font: UIFont.systemFont(ofSize: 15, weight: .regular), alighment: .left)
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .green
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()

    private let buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Buy", for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 19)
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
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    private func setupButton() {
        buyButton.addTarget(self, action: #selector(openBuyLink), for: .touchUpInside)
    }
    
    @objc func openBuyLink() {
        print("Perform")
        
//        guard let urlString = self.urlString, let url = URL(string: urlString) else { return }
//        let webView = WebViewViewController(url: url, title: "Buy Book")
//        let navVC = UINavigationController(rootViewController: webView)
//        self.window?.rootViewController?.present(navVC, animated: true)
        
        guard let urlString = self.urlString, let url = URL(string: urlString) else { return }
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        
        let vc = SFSafariViewController(url: url, configuration: config)
        self.window?.rootViewController?.present(vc, animated: true)
    }
    
    private func setupView() {
        
        layer.cornerRadius = 12
        backgroundColor = .white
        
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25),
        ])
        
        addSubview(bookNameLabel)
        bookNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([bookNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
                                     bookNameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
                                     bookNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15)
                                    ])
        
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
                                     descriptionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
                                     descriptionLabel.topAnchor.constraint(equalTo: bookNameLabel.bottomAnchor, constant: 10)
                                    ])
        
        
        
        addSubview(buyButton)
        NSLayoutConstraint.activate([
            buyButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            buyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            buyButton.widthAnchor.constraint(equalToConstant: 75),
            buyButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
}
