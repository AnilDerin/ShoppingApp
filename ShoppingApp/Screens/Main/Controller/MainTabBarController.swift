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

        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        // Hides Back Button
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        // Adding Cart Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .plain, target: self, action: #selector(goToBasket))
        
        // Tab Bar Colors
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .systemOrange
        
        // Setting up view controllers
        let productVC = ProductsViewController(viewModel: ProductsViewModel())
        let searchVC = SearchViewController(viewModel: ProductsViewModel())
        let profileVC = ProfileViewController(viewModel: ProfileViewModel())

        
        // Setting up view controller titles
        productVC.title = "Products"
        searchVC.title = "Search"
        profileVC.title = "Profile"

        // Adding view controllers
        self.viewControllers = [productVC, searchVC, profileVC]
        
        // Setting view controller images
        guard let items = self.tabBar.items else {return}
        
        let images = ["house", "magnifyingglass.circle", "person.crop.circle"]
        let selectedImages = ["house.fill", "magnifyingglass.circle.fill", "person.crop.circle.fill"]
        
        for x in 0...2 {
            items[x].image = UIImage(systemName: images[x])
            items[x].selectedImage = UIImage(systemName: selectedImages[x])
        }
    }
    
    // MARK: - Methods
    @objc
    private func goToBasket(){
        let basketVC = BasketViewController(viewModel: BasketViewModel())
        self.navigationController?.pushViewController(basketVC, animated: true)
    }
    

}
