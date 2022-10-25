//
//  LoginViewController.swift
//  ShoppingApp
//
//  Created by Bartu Gençcan on 25.10.2022.
//

import UIKit


class LoginViewController: UIViewController {
    
    private lazy var loginView: LoginView = {
        let view = LoginView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = loginView
        
      
    }
}
