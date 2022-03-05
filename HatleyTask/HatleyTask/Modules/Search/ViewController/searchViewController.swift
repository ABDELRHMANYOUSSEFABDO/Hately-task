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
        // used 300 milliseconds reduction request
        searchBar.rx.text.orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe( onNext : { quary in
                if quary.isEmpty {
                    viewModel.listArtis.onNext([])
                }else{
                    viewModel.getlistArtis(name: quary)
                }
                
            }).disposed(by: self.disposeBage)
        // used When ReloadTableView
        viewModel.listArtisObsevable.bind(to: self.listArtisTableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)){ (row, element, cell) in
            cell.nameAritsLabel.text = element.name
        }.disposed(by: self.disposeBage)
        
        // used When Select Iteams
        Observable.zip(listArtisTableView.rx.itemSelected,listArtisTableView.rx.modelSelected(Artist.self)).bind { [weak self]  selectedIndex, branch  in
            self?.coordinator.Main.navigate(to: .album(id: branch.mbid))
        }.disposed(by: self.disposeBage)
    }
}
