//
//  CoordinatorProtocol.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 01.03.2023.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
