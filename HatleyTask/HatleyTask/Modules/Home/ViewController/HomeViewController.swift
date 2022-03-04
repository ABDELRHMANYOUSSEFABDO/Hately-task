//
//  HomeViewController.swift
//  HatleyTask
//
//  Created by Apple on 3/3/22.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: BaseWireframe<HomeViewModel> {
    @IBOutlet var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchButton.rx.tap.subscribe(onNext: { [weak self] _ in
                                        let vc =  AlbumViewController(viewModel: AlbumViewModel(), coordinator: self?.coordinator as! Coordinator)
                                        self?.present(vc, animated: true, completion: nil)
            
        }).disposed(by: self.disposeBage)
        // Do any additional setup after loading the view.
    }

    override func bind(viewModel: HomeViewModel) {
        searchButton.rx.tap.subscribe(onNext: { [weak self] _ in
            let vc =  AlbumViewController(viewModel: AlbumViewModel(), coordinator: self?.coordinator as! Coordinator)
            self?.present(vc, animated: true, completion: nil)
        }).disposed(by: self.disposeBage)
    }
    

}
