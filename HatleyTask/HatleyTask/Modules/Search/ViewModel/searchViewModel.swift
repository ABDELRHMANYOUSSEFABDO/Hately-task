//
//  searchViewModel.swift
//  HatleyTask
//
//  Created by Apple on 3/4/22.
//

import Foundation
import RxSwift

class serachViewModel:BaseViewModel{
    private var networkClient = NetworkClient()
    
    private (set) var listArtis = PublishSubject<[Artist]>()
    var listArtisObsevable : Observable <[Artist]> {
        return listArtis
    }
    func getlistArtis(name:String){
        self.networkClient.performRequest(search.self, router: searchRouter.searh(name: name)).subscribe{
            switch $0{
            
            case .success(let response):
                self.listArtis.onNext(response.results.artistmatches.artist)
            case .failure(_):
                break
            }
        }.disposed(by: disposeBag )
    }
}
