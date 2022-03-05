//
//  DetilesAlbumViewModel.swift
//  HatleyTask
//
//  Created by Apple on 3/5/22.
//


import Foundation
import RxSwift
import RxCocoa
import UIKit
import RealmSwift
class DetilesAlbumViewModel:BaseViewModel{
    private var networkClient = NetworkClient()
    private var listAlbum = PublishSubject<AlbumDetiles>()
    var listAlbumObsevable : Observable <AlbumDetiles> {
        return listAlbum
    }
    private var listTrack = BehaviorRelay<[Track]>(value: [])
    private var id = ""
    private var album :Album!
    var listTrackObsevable : Observable <[Track]> {
        return listTrack.asObservable()
    }
    private (set) var isDownloadicon = BehaviorRelay<Bool>(value: false)
    init(id:String,isDowload :Bool = false,album:Album){
        self.id = id
        self.album = album
        isDownloadicon.accept(isDowload)
    }
    func getlistArtis(){
        self.networkClient.performRequest(DetilesModel.self, router: detilesRouter.detiles(id: id)).subscribe{
            switch $0{
            
            case .success(let response):
                self.listTrack.accept(response.album?.tracks?.track ?? [])
                self.listAlbum.onNext(response.album!)
            case .failure(_):
                break
            }
        }.disposed(by: self.disposeBag)
    }
     func save() {
        let realm = try! Realm()
        try! realm.write {
            album.isDonwloaded = !isDownloadicon.value
            realm.add(album,update: .modified)
        }
    }
     func remove(){
        let realm = try! Realm()
        try! realm.write{
            album.isDonwloaded = !isDownloadicon.value
            realm.add(album,update: .modified)
        }
     
    }

}
