//
//  AlbumViewController.swift
//  HatleyTask
//
//  Created by Apple on 3/4/22.
//

import UIKit
import SDWebImage
import RxSwift
import RxCocoa
import RealmSwift
class AlbumViewController: BaseWireframe<AlbumViewModel> {
    @IBOutlet var albumCollectionView: UICollectionView!{
        didSet{
            self.albumCollectionView.register(UINib(nibName: AlbumCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: AlbumCollectionViewCell.identifier)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getAlbum()
    }
    override func bind(viewModel: AlbumViewModel) {
        viewModel.getAlbum()
        viewModel.listAlbumObsevable.bind(to: self.albumCollectionView.rx.items(cellIdentifier: AlbumCollectionViewCell.identifier, cellType: AlbumCollectionViewCell.self)){ (row, element, cell) in
            cell.nameAlbumLabel.text = element.name
            cell.nameArtiesLabel.text = element.artist?.name
            var imageLink = ""
            if (!element.imageList.isEmpty){
                 imageLink = (element.imageList[0].imageLink) ?? ""
                
            }else{
                imageLink = element.image ?? ""
            }
           
            let imageURl = URL(string: imageLink)

            cell.imageAlbum.sd_setImage(with: imageURl, placeholderImage: #imageLiteral(resourceName: "Hatley"),options: SDWebImageOptions(rawValue: 0), completed: { image, error, cacheType, imageURL in
                // your rest code
           })
            let imageButton = element.isDonwloaded ? #imageLiteral(resourceName: "heart_fill_icon") : #imageLiteral(resourceName: "heart_gray_icon")
            cell.storeButton.setImage(imageButton, for: .normal)
            cell.storeButton.rx.tap.subscribe(onNext:  {[weak self] _ in
                self?.viewModel.downLoadClicked(index:row,album: element)
               
            }).disposed(by: cell.disposeBag)
            
        }.disposed(by: self.disposeBage)
        
        Observable.zip(albumCollectionView.rx.itemSelected,albumCollectionView.rx.modelSelected(Album.self)).bind { [weak self]  selectedIndex, branch  in
            if branch.mbid != nil{
                self?.coordinator.Main.navigate(to: .detiles(id: branch.mbid, isDowload: branch.isDonwloaded, album: branch))
            }else{
               
            }
        }.disposed(by: self.disposeBage)
        
    }
}
