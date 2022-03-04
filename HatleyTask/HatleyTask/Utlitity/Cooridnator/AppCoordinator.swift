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
    
}
class AppCoordinator: Coordinator{
    let window : UIWindow
    lazy  var Main : MainNavigators = {
        return .init(coordinator: self)
    }()
    init(window:UIWindow = UIWindow()) {
        self.window = window
    }
    func start(){
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    var rootViewController : UIViewController{
        let viewModels = HomeViewModel()
        return HomeViewController(viewModel: viewModels, coordinator: self)
    }
}
