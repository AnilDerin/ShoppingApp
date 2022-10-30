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
        
        // Hides Back Button
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        // Tab Bar Colors
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .systemOrange
        
        // Setting up view controllers
        let productVC = ProductsViewController(viewModel: ProductsViewModel())
        let searchVC = SearchViewController()
        let profileVC = ProfileViewController()
        
        // Setting up view controller titles
        productVC.title = "Products"
        searchVC.title = "Search"
        profileVC.title = "Profile"

        // Adding view controllers
        self.setViewControllers([productVC, searchVC, profileVC], animated: false)
        
        // Setting view controller images
        guard let items = self.tabBar.items else {return}
        
        let images = ["house", "magnifyingglass.circle", "person.crop.circle"]
        let selectedImages = ["house.fill", "magnifyingglass.circle.fill", "person.crop.circle.fill"]
        
        for x in 0...2 {
            items[x].image = UIImage(systemName: images[x])
            items[x].selectedImage = UIImage(systemName: selectedImages[x])
        }
    }
    

}
