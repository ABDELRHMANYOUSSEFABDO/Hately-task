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
import RealmSwift
class AlbumViewModel:BaseViewModel{
    private var networkClient = NetworkClient()
    private var listAlbum = BehaviorRelay<[Album]>(value: [])
    var listAlbumObsevable : Observable <[Album]> {
        return listAlbum.asObservable()
    }
    private var id = ""
    init(id:String){
        self.id = id
    }
    func getAlbum(){
        let localArray = getArrayFromRealm(type: Album.self)
        self.networkClient.performRequest(MainModelClass.self, router: albumRouter.album(id: id)).subscribe{
            switch $0{
            
            case .success(let response):
                guard let topAlbum = response.topalbums else{
                    self.listAlbum.accept([])
                    
                    return
                }
                var albums = Array(topAlbum.album)
                if localArray.count == 0 {
                    self.listAlbum.accept(albums)
                    return
                }
                
                // used  to merge Data from Api and Realm
                for (index,serverAlbum) in albums.enumerated(){
                    localArray.forEach{ localAlbum in
                        if(serverAlbum.name == localAlbum.name){
                            albums = albums.filter{$0.name != localAlbum.name}
                            albums.insert(localAlbum, at: index)
                        }
                    }
                    
                }
                self.listAlbum.accept(albums)
            case .failure(_):
                break
            }
        }.disposed(by: disposeBag)
    }
    func downLoadClicked(index:Int,album:Album){
        let newAlbum:Album = .init(id: album.mbid, name: album.name, url: album.url, isDowload: !album.isDonwloaded, aritst: album.artist, imageList: album.imageList)
        let albumsFromServer = listAlbum.value
        
        var alb =  albumsFromServer
            
            .filter{$0.name != album.name} // mbid is not unique and most of time is nil
        
        alb.insert(newAlbum, at: index)
        newAlbum.isDonwloaded ? save(album: newAlbum) : remove(album: album)
        self.listAlbum.accept(alb)
        
    }
    
    private func save(album:Album) {
        album.isDonwloaded = true
        if !album.imageList.isEmpty {
            album.image = album.imageList[0].imageLink
        }
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(album, update: .modified)
        }
        
    }
    private func remove(album:Album){
        let realm = try! Realm()
        try? realm.write {
            realm.delete(album)
        }
        
    }
    
    private func getArrayFromRealm<T:Object>(type:T.Type)->[T]{
        guard  let albmus = try?  Realm().objects(T.self).toArray(ofType: T.self) as [T]else{
            return []
        }
        return albmus
    }
}

