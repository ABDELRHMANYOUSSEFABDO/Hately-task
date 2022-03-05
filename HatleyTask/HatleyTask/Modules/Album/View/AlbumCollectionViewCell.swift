//
//  AlbumCollectionViewCell.swift
//  HatleyTask
//
//  Created by Apple on 3/4/22.
//

import UIKit
import RxSwift
class AlbumCollectionViewCell: UICollectionViewCell {
    var disposeBag = DisposeBag()
    @IBOutlet var storeButton: UIButton!
    @IBOutlet var nameArtiesLabel: UILabel!
    @IBOutlet var nameAlbumLabel: UILabel!
    @IBOutlet var imageAlbum: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    
}
