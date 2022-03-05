//
//  MainNavigators.swift
//  HatleyTask
//
//  Created by Apple on 3/3/22.
//

import Foundation
import UIKit

class MainNavigators:Navigator {
    var coordinator: Coordinator
    
    enum Destionation {
        case search
        case detiles(id:String,isDowload:Bool = false,album:Album)
    }
    required init(coordinator:Coordinator){
        self.coordinator = coordinator
    }
    func ViewController(for destination : Destionation) -> UIViewController {
        switch destination {
        case .search:
            let viewmodel  = AlbumViewModel()
            let View = AlbumViewController(viewModel: viewmodel, coordinator: coordinator)
            return View
        case let .detiles(id,isDowload,album) :
            let viewmodel = DetilesAlbumViewModel(id: id, isDowload: isDowload,album: album)
            let View = DetilesAlbumViewController(viewModel: viewmodel, coordinator: coordinator)
            return View
            
        default:
            break
        }
    }
}
