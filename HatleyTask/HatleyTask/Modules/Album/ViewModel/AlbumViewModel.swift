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
class AlbumViewModel{
    private var networkClient = NetworkClient()
    private var listAlbum = PublishSubject<[Album]>()
    var listAlbumObsevable : Observable <[Album]> {
        return listAlbum

    }
    func getAlbum(id:String){
        self.networkClient.performRequest(MainModelClass.self, router: albumRouter.album(id: id)).subscribe{
            switch $0{
            
            case .success(let response):
                print("Hi",response.topalbums?.album.count)
                var arrayalbum :  [Album] = []
                 response.topalbums?.album.map { arrayalbum.append($0) }
                for i in  (response.topalbums?.album)! {
                    arrayalbum.append(i)
                }
                self.listAlbum.onNext(arrayalbum)
            case .failure(_):
                break
            }
        }
    }
}

