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
    var id: String = "e520459c-dff4-491d-a6e4-c97be35e0044"
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.reloadData.subscribe(onNext:{ _ in
            self.albumCollectionView.reloadData()
        }).disposed(by: viewModel.disposeBag)
    }
    override func bind(viewModel: AlbumViewModel) {
        viewModel.getAlbum(id: id)
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
            let imageButton = element.isDonwloaded ? #imageLiteral(resourceName: "heart_fill_icon") : #imageLiteral(resourceName: "heart_gray_icon")
            cell.storeButton.setImage(imageButton, for: .normal)
            cell.storeButton.rx.tap.subscribe(onNext:  {[weak self] _ in
                self?.viewModel.downLoadClicked(index:row,album: element)
               
            }).disposed(by: cell.disposeBag)
            
        }.disposed(by: self.disposeBage)
        
    }
    
    private func getArrayFromRealm<T:Object>(type:T.Type)->[T]{
        guard  let albmus = try?  Realm().objects(T.self).toArray(ofType: T.self) as [T]else{
            return []
        }
        print("All Albmus",albmus)
        return albmus
    }
    private func getAlbum()->[Album]{
        guard  let albmus = try?  Realm().objects(Album.self).toArray(ofType: Album.self) as [Album]else{
            return []
        }
        print("All Albmus",albmus)
        return albmus
    }
    private func save(album:Album) {
        let realm = try! Realm()

        try! realm.write {
            realm.add(album)
        }
    }
    private func remove(album:Album){
        let realm = try! Realm()
        try! realm.write{
            realm.delete(album)
        }
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }

        return array
    }
}
