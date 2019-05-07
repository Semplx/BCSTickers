//
//  AppCoordinator.swift
//  BCSTest
//
//  Created by Олег Мельник on 05/05/2019.
//  Copyright © 2019 Oleg Melnik. All rights reserved.
//

import UIKit

class AppCoordinator {
    
    let window: UIWindow
    private let networkManager = NetworkManager()
    private let updatableViewModel: UpdatableViewModel
    
    init(window: UIWindow) {
        self.window = window
        updatableViewModel = TickersViewModel(networkManager: networkManager)
    }
    
    func start() {
        window.makeKeyAndVisible()
        let viewController = MainViewController()
        viewController.tabBarViewControllers = getViewControllers()
        window.rootViewController = viewController
    }
    
    func stopUpdating() {
        updatableViewModel.stopUpdating()
    }
    
    func startUpdatingIfNeeded() {
        if updatableViewModel.needsUpdate && !updatableViewModel.isUpdating {
            updatableViewModel.startUpdating()
        }
    }
    
    private func getViewControllers() -> [UIViewController] {
        let tickersController = TickersController()
        guard let viewModel = updatableViewModel as? TickersViewModel else { return [] }
        tickersController.viewModel = viewModel
        tickersController.tabBarItem = UITabBarItem(tabBarSystemItem: .recents, tag: 1)
        let navController = UINavigationController(rootViewController: tickersController)
        
        let secondController = SecondViewController()
        secondController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)
        
        return [navController, secondController]
    }
}
