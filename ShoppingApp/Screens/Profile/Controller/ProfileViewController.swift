//
//  ProfileViewController.swift
//  ShoppingApp
//
//  Created by Bartu Gençcan on 30.10.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var viewModel: ProfileViewModel
    
    // MARK: - Init
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        
        viewModel.getCollectionData()

    }
}



