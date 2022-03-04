//
//  MainNavigators.swift
//  HatleyTask
//
//  Created by Apple on 3/3/22.
//

import Foundation
import UIKit

class MainNavigators:Navigator {
    var coordinator: Coordinator
    
    enum Destionation {
        case search
    }
    required init(coordinator:Coordinator){
        self.coordinator = coordinator
    }
    func ViewController(for destination : Destionation) -> UIViewController {
        switch destination {
        case .search:
            let viewmodel  = serachViewModel()
            let View = searchViewController(viewModel: viewmodel, coordinator: coordinator)
            return View
        default:
            break
        }
    }
}
