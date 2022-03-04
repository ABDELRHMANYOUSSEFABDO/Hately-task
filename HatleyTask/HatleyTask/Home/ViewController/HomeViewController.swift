//
//  HomeViewController.swift
//  HatleyTask
//
//  Created by Apple on 3/3/22.
//

import UIKit

class HomeViewController: BaseWireframe<HomeViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func tabButton(_ sender: Any) {
        coordinator.Main.ViewController(for: .search)
    }
    

}
