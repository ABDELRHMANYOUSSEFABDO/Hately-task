//
//  searchViewController.swift
//  HatleyTask
//
//  Created by Apple on 3/3/22.
//

import UIKit
import RxSwift
import RxCocoa
class searchViewController: BaseWireframe<serachViewModel> {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var listArtisTableView: UITableView!  {
        didSet{
            self.listArtisTableView.register(UINib(nibName: SearchTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SearchTableViewCell.identifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func bind(viewModel: serachViewModel) {
        searchBar.rx.text.orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe( onNext : { quary in
                viewModel.getlistArtis(name: quary)
                
            }).disposed(by: self.disposeBage)
        viewModel.listArtisObsevable.bind(to: self.listArtisTableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)){ (row, element, cell) in
            cell.nameAritsLabel.text = element.name
        }.disposed(by: self.disposeBage)
    }
}