//
//  AbstractCoordinator.swift
//  NYTTestPysarenkoDev
//
//  Created by Vladimir Pisarenko on 02.03.2023.
//

import Foundation

protocol AbstractCoordinator {
    func addChildCoordinator(_ coordinator: AbstractCoordinator)
    func removeAllChildCoordinatorsWith<T>(type: T.Type)
    func removeAllChildCoordinators()
}
