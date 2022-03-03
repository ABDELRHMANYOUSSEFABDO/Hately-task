//
//  BaseWireframe.swift
//  HatleyTask
//
//  Created by Apple on 3/3/22.
//

import Foundation
import UIKit
class BaseWireframe<T>: UIViewController{
    let viewModel:  T
    init(viewModel:T) {
        
        self.viewModel = viewModel
        //super.init(nibName: String(type(of: self)), bundle: nil)
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init")
    }
}
