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
    let authorLabel = UILabel(font: UIFont.systemFont(ofSize: 15, weight: .semibold), alighment: .left)
    let descriptionLabel = UILabel(font: UIFont.systemFont(ofSize: 13, weight: .regular), alighment: .left)
    
    let publisherLabel = UILabel(font: UIFont.systemFont(ofSize: 15, weight: .regular), alighment: .left)
    let rankLabel = UILabel(font: UIFont.systemFont(ofSize: 15, weight: .regular), alighment: .left)
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = UIColor(cgColor: CGColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1))
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
        setConstraints()
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setConstraints()
        setupButton()
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    override func layoutSubviews() {
        
        if UIDevice.current.orientation.isLandscape {
            bookNameLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
            authorLabel.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
            descriptionLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            publisherLabel.font = UIFont.systemFont(ofSize: 19, weight: .regular)
            rankLabel.font = UIFont.systemFont(ofSize: 19, weight: .regular)
            buyButton.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 21)
        } else {
            bookNameLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            authorLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            descriptionLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
            publisherLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            rankLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            buyButton.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 19)
        }
    }
    
    private func setupButton() {
        buyButton.addTarget(self, action: #selector(openBuyLink), for: .touchUpInside)
    }
    
    @objc func openBuyLink() {
//        print("Perform")
        
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
        backgroundColor = .tertiarySystemBackground
        
        addSubview(imageView)
        addSubview(buyButton)
        addSubview(bookNameLabel)
        addSubview(authorLabel)
        addSubview(descriptionLabel)
        addSubview(rankLabel)
        addSubview(publisherLabel)

        descriptionLabel.numberOfLines = 3
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.75),
        ])
        
        NSLayoutConstraint.activate([
            buyButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            buyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            buyButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            buyButton.widthAnchor.constraint(equalTo: buyButton.heightAnchor, multiplier: 3),
        ])
        
        NSLayoutConstraint.activate([
            bookNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            bookNameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            bookNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: bookNameLabel.bottomAnchor, constant: 3),
            authorLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 3),
            descriptionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: buyButton.leadingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            rankLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            rankLabel.trailingAnchor.constraint(equalTo: buyButton.leadingAnchor, constant: -15),
            rankLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        ])
        
        NSLayoutConstraint.activate([
            publisherLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            publisherLabel.trailingAnchor.constraint(equalTo: buyButton.leadingAnchor, constant: -15),
            publisherLabel.bottomAnchor.constraint(equalTo: rankLabel.topAnchor, constant: 0)
        ])
    }
}
