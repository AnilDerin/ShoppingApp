//
//  LoginViewController.swift
//  ShoppingApp
//
//  Created by Bartu Gençcan on 25.10.2022.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    private let viewModel: LoginViewModel
    
    enum AuthType: String {
        case signIn = "Sign In"
        case signUp = "Sign Up"
        
        init(text: String) {
            switch text {
            case "Sign In":
                self = .signIn
            case "Sign Up":
                self = .signUp
            default:
                self = .signIn
            }
        }
    }
    
    var authType: AuthType = .signIn {
        didSet {
            let buttonTitle = loginView.segmentedControl.titleForSegment(at: loginView.segmentedControl.selectedSegmentIndex)
            loginView.finishAuthButton.setTitle(buttonTitle, for: .normal)
        }
    }
    
    private lazy var loginView: LoginView = {
        let view = LoginView()
        view.delegate = self
        return view
    }()
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Auth"
        
        viewModel.changeHandler = { change in
            switch change {
            case .didErrorOccured(let error):
                print(error.localizedDescription)
            case .didSignUpSuccessful:
                print("Sign Up Successful")
            }
        }
        
        view = loginView
        loginView.segmentedControl.selectedSegmentIndex = 0
        
        viewModel.fetchRemoteConfig { isSignUpDisabled in
            self.loginView.segmentedControl.isHidden = isSignUpDisabled
        }
        
    }
}

extension LoginViewController: LoginViewDelegate {
    func didTapFinishAuthButton(sender: UIButton) {
        
        guard let email = loginView.emailTextField.text else {return}
        guard let password = loginView.passwordTextField.text else {return}
        
        switch authType {
        case .signIn:
            viewModel.signIn(email: email, password: password)
            
        case .signUp:
            viewModel.signUp(email: email, password: password)
        }
    }
    
    func didAuthChange(segmentedControl: UISegmentedControl) {
        let buttonTitle = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
        authType = AuthType(text: buttonTitle ?? "Sign In")
        print(authType)
    }
    
    func didTapShowPasswordButton(sender: UIButton) {
        if loginView.passwordTextField.isSecureTextEntry == true {
            loginView.passwordTextField.isSecureTextEntry = false
        } else {
            loginView.passwordTextField.isSecureTextEntry = true
        }
    }
}
