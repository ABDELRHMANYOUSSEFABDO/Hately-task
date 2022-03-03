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
}
