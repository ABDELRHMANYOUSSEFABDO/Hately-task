//
//  AlbumViewController.swift
//  HatleyTask
//
//  Created by Apple on 3/4/22.
//

import UIKit
import SDWebImage
class AlbumViewController: BaseWireframe<AlbumViewModel> {
    @IBOutlet var albumCollectionView: UICollectionView!{
        didSet{
            self.albumCollectionView.register(UINib(nibName: AlbumCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: AlbumCollectionViewCell.identifier)
        }
    }
    var id: String = "e520459c-dff4-491d-a6e4-c97be35e0044"
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func bind(viewModel: AlbumViewModel) {
        viewModel.getAlbum(id: id)
        viewModel.listAlbumObsevable.bind(to: self.albumCollectionView.rx.items(cellIdentifier: AlbumCollectionViewCell.identifier, cellType: AlbumCollectionViewCell.self)){ (row, element, cell) in
            
            cell.nameAlbumLabel.text = element.name
            cell.nameArtiesLabel.text = element.artist?.name
            let imageURl = URL(string: element.image ?? "")

            cell.imageAlbum.sd_setImage(with: imageURl, placeholderImage: #imageLiteral(resourceName: "heart_gray_icon"),options: SDWebImageOptions(rawValue: 0), completed: { image, error, cacheType, imageURL in
                // your rest code
           })
        }.disposed(by: self.disposeBage)
        
    }

    
}
