//
//  Navigator.swift
//  HatleyTask
//
//  Created by Apple on 3/3/22.
//

import Foundation
import UIKit
protocol Navigator {
  associatedtype Destionation
    func ViewController(for destionation :Destionation) -> UIViewController
    var coordinator : Coordinator {get}
    func navigate(to  destionation :Destionation)
}
extension Navigator{
    func navigate(to destionation :Destionation ){
        let viewController = self.ViewController(for: destionation)
        coordinator.navigationController.pushViewController(viewController, animated: true)
    }
}
