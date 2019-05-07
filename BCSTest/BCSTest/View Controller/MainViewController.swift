//
//  ViewController.swift
//  BCSTest
//
//  Created by Олег Мельник on 2019-02-17.
//  Copyright © 2019 Олег Мельник. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var tabBarVC: UITabBarController!
    
    var tabBarViewControllers: [UIViewController]?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        setUpTabBar()
        tabBarVC.viewControllers = tabBarViewControllers
    }
    
    private func setUpTabBar() {
        tabBarVC = UITabBarController()
        addChild(tabBarVC)
        view.addSubview(tabBarVC.view)
        tabBarVC.view.translatesAutoresizingMaskIntoConstraints = false
        tabBarVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tabBarVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tabBarVC.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tabBarVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
