//
//  MainTabBarController.swift
//  ShoppingApp
//
//  Created by Bartu Gençcan on 26.10.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        // Do any additional setup after loading the view.
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
    

}
