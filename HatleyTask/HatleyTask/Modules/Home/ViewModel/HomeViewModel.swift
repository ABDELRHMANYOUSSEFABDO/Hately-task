//
//  HomeViewModel.swift
//  HatleyTask
//
//  Created by Apple on 3/3/22.
//

import RxSwift
import RxCocoa
import RealmSwift
class HomeViewModel {
    private var listAlbum = BehaviorRelay<[Album]>(value: [])
    var listAlbumObsevable : Observable <[Album]> {
        return listAlbum.asObservable()
        
    }
     func getAlbum()->[Album]{
        guard  let albmus = try?  Realm().objects(Album.self).toArray(ofType: Album.self) as [Album]else{
            return []
        }
        print("All Local Albmus",albmus)
        listAlbum.accept(albmus)
        return albmus
    }
    func remove(album:Album){
        print(" LOLO Remove",album)
        let realm = try! Realm()

        
        try? realm.write {
            realm.delete(album)
        }
         getAlbum()
    }
}
