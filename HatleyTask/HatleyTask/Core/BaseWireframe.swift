//
//  BaseWireframe.swift
//  HatleyTask
//
//  Created by Apple on 3/3/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
class BaseWireframe<T>: UIViewController{
    let viewModel:  T
    var coordinator: Coordinator
    lazy var disposeBage : DisposeBag = {
        return DisposeBag()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(viewModel: viewModel)
    }
    
    init(viewModel:T,coordinator:Coordinator) {
        
        self.viewModel = viewModel
        //super.init(nibName: String(type(of: self)), bundle: nil)
        self.coordinator = coordinator
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
        
    }
    func bind(viewModel:T){
        fatalError("Please override bind function")
    }
    required init?(coder: NSCoder) {
        fatalError("init")
    }
}
