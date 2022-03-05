//
//  DetilesAlbumViewController.swift
//  HatleyTask
//
//  Created by Apple on 3/5/22.
//

import UIKit
import SDWebImage
class DetilesAlbumViewController:BaseWireframe<DetilesAlbumViewModel> {
    @IBOutlet weak var imageArtis: UIImageView!
    @IBOutlet weak var nameArties: UILabel!
    @IBOutlet  weak var nameAlbum: UILabel!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet weak var trackTableView: UITableView! {
        didSet{
            self.trackTableView.register(UINib(nibName: SearchTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SearchTableViewCell.identifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func bind(viewModel: DetilesAlbumViewModel) {
        viewModel.getlistArtis()
        viewModel.listTrackObsevable.bind(to: self.trackTableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)){ [weak self] (row, element, cell) in
            cell.nameAritsLabel.text = element.name
        }.disposed(by: self.disposeBage)
        viewModel.listAlbumObsevable.subscribe( { [weak self] elment in
            self?.nameAlbum.text = elment.element?.name
            self?.nameArties.text = elment.element?.artist
            let imageUrl = URL(string: elment.element?.image?[0].text ?? "")
           
            self?.imageArtis.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "heart_gray_icon"),options: SDWebImageOptions(rawValue: 0), completed: { image, error, cacheType, imageURL in
           })
//
            viewModel.isDownloadicon.subscribe({[weak self] sucess in
                if sucess.element == true{
                    self?.saveButton.setImage(#imageLiteral(resourceName: "heart_fill_icon"), for: .normal)
                }else{
                    self?.saveButton.setImage(#imageLiteral(resourceName: "heart_gray_icon"), for: .normal)
                }
            }).disposed(by: self!.disposeBage)

        }).disposed(by: self.disposeBage)
        saveButton.rx.tap.subscribe({_ in
            !viewModel.isDownloadicon.value ? viewModel.save() : viewModel.remove()
            viewModel.isDownloadicon.accept(!viewModel.isDownloadicon.value)
        }).disposed(by: disposeBage)
    }

}
