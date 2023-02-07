//
//  BuyLinksAlertController.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 07.02.2023.
//

import UIKit
import SafariServices

public enum BuyLinksAlert {
    case chooseAction
    case buyIn
    case cancel
    
    public var comandName: String {
        switch self {
        case .chooseAction:
            return "Choose action".localized()
        case .buyIn:
            return "Buy in ".localized()
        case .cancel:
            return "Cancel".localized()
        }
    }
    
    
    public static func instagramAlertController(buyLinks: [BuyLinkEntity], rootVC: UIViewController) -> UIAlertController {
        let gramsAlertController = UIAlertController(title: BuyLinksAlert.chooseAction.comandName.localized(), message: nil, preferredStyle: .actionSheet)
        
        for buyLink in buyLinks {
            if let nameMarket = buyLink.marketName, let buyLink = buyLink.buyLinkUrl {
                
                let openAction = UIAlertAction(title: BuyLinksAlert.buyIn.comandName.localized() + nameMarket, style: .default) { action in
                    guard let url = URL(string: buyLink) else { return }
                    let config = SFSafariViewController.Configuration()
                    config.entersReaderIfAvailable = true
                    
                    let vc = SFSafariViewController(url: url, configuration: config)
                    rootVC.present(vc, animated: true)
                }
                gramsAlertController.addAction(openAction)
            }
        }
        let cancelAction = UIAlertAction(title: BuyLinksAlert.cancel.comandName.localized(), style: .cancel)
        gramsAlertController.addAction(cancelAction)
        
        return gramsAlertController
    }
}
