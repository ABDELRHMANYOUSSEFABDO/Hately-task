//
//  AppCoordinator.swift
//  HatleyTask
//
//  Created by Apple on 3/3/22.
//

import Foundation
import UIKit
protocol Coordinator {
    var  Main : MainNavigators { get}
    var navigationController: UINavigationController { get}

    
}
class AppCoordinator: Coordinator{
    var navigationController: UINavigationController
    let window : UIWindow
    lazy  var Main : MainNavigators = {
        return .init(coordinator: self)
    }()
  //  private  var navigationController: UINavigationController?
   
    init(window:UIWindow = UIWindow(),navigationController: UINavigationController = UINavigationController()) {
        self.window = window
        self.navigationController = navigationController
    }
    func start(){
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    var rootViewController : UIViewController{
        let viewModels = HomeViewModel()
        let home =   HomeViewController(viewModel: viewModels, coordinator: self)
        let navController = UINavigationController(rootViewController: home)
//        navController.navigationBar.isHidden = true
        self.navigationController = navController
        return navController
    }
}
