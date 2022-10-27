//
//  LoginView.swift
//  ShoppingApp
//
//  Created by Bartu Gençcan on 25.10.2022.
//

import Foundation
import UIKit

protocol LoginViewDelegate: AnyObject {
    func didTapFinishAuthButton(sender: UIButton)
    func didAuthChange(segmentedControl: UISegmentedControl)
}

class LoginView: UIView {
    
    // MARK: - Properties
    weak var delegate: LoginViewDelegate?
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Swift Shop"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        return label
    }()
    
    private(set) lazy var segmentedControl: UISegmentedControl = {
        let items = ["Sign In","Sign Up"]
       let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.addTarget(self, action: #selector(didAuthChange(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    private(set) lazy var usernameTextField: UITextField = {
        let textField = UITextField()
         textField.placeholder = "Username"
         textField.layer.cornerRadius = 12
         textField.layer.borderWidth = 1
        textField.isHidden = true
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
        textField.leftView = leftView
        textField.leftViewMode = .always
         return textField
    }()
    
    private(set) lazy var emailTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Email"
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
        textField.leftView = leftView
        textField.leftViewMode = .always
        return textField
    }()
    
    private(set) lazy var passwordTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Password"
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.isSecureTextEntry = true
        textField.clearsOnBeginEditing = false
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
        textField.leftView = leftView
        textField.leftViewMode = .always
        return textField
    }()
    
    private(set) lazy var passwordConfirmTextField: UITextField = {
        let textField = UITextField()
         textField.placeholder = "Password"
         textField.layer.cornerRadius = 12
         textField.layer.borderWidth = 1
         textField.isSecureTextEntry = true
         textField.clearsOnBeginEditing = false
         textField.isHidden = true
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
        textField.leftView = leftView
        textField.leftViewMode = .always
         return textField
    }()
    
    private(set) lazy var finishAuthButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.addTarget(self, action: #selector(didTapFinishAuthButton(_:)), for: .touchUpInside)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 16
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Layout
extension LoginView {
    
    private func titleLabelLayout(){
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(128.0)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
    
    private func segmentedControlLayout(){
        addSubview(segmentedControl)
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(64.0)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
    
    private func usernameTextFieldLayout(){
        addSubview(usernameTextField)
        
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(64.0)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(32.0)
            make.leading.equalTo(32.0)
            make.trailing.equalTo(-32.0)
        }
    }
    
    private func emailTextFieldLayout(){
        addSubview(emailTextField)
            emailTextField.snp.makeConstraints { make in
                make.top.equalTo(segmentedControl.snp.bottom).offset(112.0)
                make.centerX.equalTo(self.snp.centerX)
                make.height.equalTo(32.0)
                make.leading.equalTo(32.0)
                make.trailing.equalTo(-32.0)
            }
        
    }
    
    private func passwordTextFieldLayout(){
        addSubview(passwordTextField)
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(16.0)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(32.0)
            make.leading.equalTo(32.0)
            make.trailing.equalTo(-32.0)
        }
    }
    
    private func passwordConfirmTextFieldLayout(){
        addSubview(passwordConfirmTextField)
        
        passwordConfirmTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(16.0)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(32.0)
            make.leading.equalTo(32.0)
            make.trailing.equalTo(-32.0)
        }
    }
    
    private func finishAuthButtonLayout(){
        addSubview(finishAuthButton)
        
        finishAuthButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-32.0)
            make.leading.equalTo(64.0)
            make.trailing.equalTo(-64.0)
        }
    }
    
    private func layout(){
            titleLabelLayout()
            segmentedControlLayout()
            usernameTextFieldLayout()
            emailTextFieldLayout()
            passwordTextFieldLayout()
            passwordConfirmTextFieldLayout()
            finishAuthButtonLayout()
    }
}

// MARK: - Methods
extension LoginView {
    @objc private func didTapFinishAuthButton(_ sender: UIButton){
        delegate?.didTapFinishAuthButton(sender: sender)
    }
    
    @objc private func didAuthChange(_ segmentedControl: UISegmentedControl){
        delegate?.didAuthChange(segmentedControl: segmentedControl)
    }
}
