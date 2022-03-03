//
//  AppDelegate.swift
//  HatleyTask
//
//  Created by Apple on 3/3/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var coordinator : AppCoordinator!



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        coordinator = AppCoordinator()
        coordinator.start()
        return true
    }

    // MARK: UISceneSession Lifecycle

}

