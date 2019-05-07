//
//  AppDelegate.swift
//  BCSTest
//
//  Created by Олег Мельник on 2019-02-17.
//  Copyright © 2019 Олег Мельник. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        coordinator = AppCoordinator(window: window)
        coordinator?.start()
        
        return true
    }


    func applicationWillResignActive(_ application: UIApplication) {
        coordinator?.startUpdatingIfNeeded()
    }


    func applicationDidEnterBackground(_ application: UIApplication) {
        coordinator?.stopUpdating()
    }


    func applicationWillEnterForeground(_ application: UIApplication) {
        coordinator?.startUpdatingIfNeeded()
    }


    func applicationDidBecomeActive(_ application: UIApplication) {
        coordinator?.startUpdatingIfNeeded()
    }


    func applicationWillTerminate(_ application: UIApplication) {
        coordinator?.stopUpdating()
    }



}
