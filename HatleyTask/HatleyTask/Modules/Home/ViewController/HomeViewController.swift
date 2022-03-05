//
//  HomeViewController.swift
//  HatleyTask
//
//  Created by Apple on 3/3/22.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage
class HomeViewController: BaseWireframe<HomeViewModel> {
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var albumCollectionView: UICollectionView!{
        didSet{
            self.albumCollectionView.register(UINib(nibName: AlbumCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: AlbumCollectionViewCell.identifier)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        }

    override func bind(viewModel: HomeViewModel) {
        searchButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.coordinator.Main.navigate(to: .search)

        }).disposed(by: self.disposeBage)
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

            cell.imageAlbum.sd_setImage(with: imageURl, placeholderImage: #imageLiteral(resourceName: "heart_gray_icon"),options: SDWebImageOptions(rawValue: 0), completed: { image, error, cacheType, imageURL in
                // your rest code
           })
            let imageButton =  #imageLiteral(resourceName: "heart_fill_icon")
            cell.storeButton.setImage(imageButton, for: .normal)
            cell.storeButton.rx.tap.subscribe(onNext:  {[weak self] _ in
                viewModel.remove(album: element)
               
            }).disposed(by: cell.disposeBag)
            
        }.disposed(by: self.disposeBage)
    }
    

}
