//
//  AlbumViewModel.swift
//  HatleyTask
//
//  Created by Apple on 3/4/22.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit
class AlbumViewModel:BaseViewModel{
    private var networkClient = NetworkClient()
    private var listAlbum = PublishSubject<[Album]>()
    var listAlbumObsevable : Observable <[Album]> {
        return listAlbum
        
    }
    func getAlbum(id:String){
        self.networkClient.performRequest(MainModelClass.self, router: albumRouter.album(id: id)).subscribe{
            switch $0{
            
            case .success(let response):
                guard let topAlbum = response.topalbums else{
                    self.listAlbum.onNext([])
                    return
                }
                let albums = Array(topAlbum.album)
                
                self.listAlbum.onNext(albums)
            case .failure(let e):
                break
            }
        }.disposed(by: disposeBag)
    }
}

