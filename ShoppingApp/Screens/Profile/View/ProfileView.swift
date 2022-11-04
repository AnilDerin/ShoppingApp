//
//  ProfileView.swift
//  ShoppingApp
//
//  Created by Bartu Gençcan on 1.11.2022.
//

import Foundation
import UIKit

protocol ProfileViewDelegate: AnyObject {
    func didTapLogOutButton(sender: UIButton)
    func didTapChangeUserCredentials(sender: UIButton)
    func didTapChangeButton(sender: UIButton)
    func didImageTapped(tapGestureRecognizer: UITapGestureRecognizer)
}

class ProfileView: UIView {
    // MARK: - Props
    
    weak var delegate: ProfileViewDelegate?
    
    var email: String? {
        didSet {
            emailLabel.text = email
        }
    }
    
    var image: UIImage? {
        didSet {
            profileImageView.image = image
        }
    }

    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didImageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        return imageView
    }()
    
    private lazy var usernameLabel: UILabel = {
       let label = UILabel()
        label.text = "Username"
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        return label
    }()
    
    private(set) lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 3
        textField.layer.borderColor = UIColor.systemOrange.cgColor
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    private lazy var changeButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change", for: .normal)
        button.addTarget(self, action: #selector(didTapChangeButton), for: .touchUpInside)
        button.titleLabel?.textColor = .systemOrange
        button.tintColor = .systemOrange
        return button
    }()
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.backgroundColor = .systemOrange
        button.addTarget(self, action: #selector(didTapLogOutButton), for: .touchUpInside)
        button.layer.cornerRadius = 16
        return button
    }()
    
    private lazy var changeCredentialsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Change Username", for: .normal)
        button.backgroundColor = .systemOrange
        button.addTarget(self, action: #selector(didTapChangeUserCredentials), for: .touchUpInside)
        button.layer.cornerRadius = 16
        return button
    }()

    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        logOutButtonLayout()
        emailLabelLayout()
        imageViewLayout()
        usernameLabelLayout()
        usernameTextFieldLayout()
        changeButtonLayout()
        changeCredentialsButtonLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
extension ProfileView {
    private func logOutButtonLayout(){
        addSubview(logOutButton)
        
        logOutButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(32.0)
            make.trailing.equalTo(-16.0)
            make.width.equalTo(128.0)
            make.height.equalTo(32.0)
        }
    }
    
    private func emailLabelLayout(){
        addSubview(emailLabel)
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(logOutButton.snp.bottom).offset(32.0)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
    
    private func imageViewLayout(){
        addSubview(profileImageView)
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(32.0)
            make.size.equalTo(240.0)
            make.centerX.equalTo(self.snp.centerX)
        }

        profileImageView.layer.cornerRadius = 120
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor.gray.cgColor
    }
    
    private func usernameLabelLayout(){
        usernameTextField.addSubview(usernameLabel)
        
        usernameLabel.snp.makeConstraints { make in
            make.leading.equalTo(usernameTextField.snp.leading)
            make.bottom.equalTo(usernameTextField.snp.top).offset(-8.0)
        }
    }
    
    private func usernameTextFieldLayout(){
        addSubview(usernameTextField)
        
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(64.0)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(32.0)
            make.leading.equalTo(32.0)
            make.trailing.equalTo(-32.0)
        }
    }
    
    private func changeButtonLayout(){
        addSubview(changeButton)
        
        changeButton.snp.makeConstraints { make in
            make.trailing.equalTo(usernameTextField.snp.trailing)
            make.bottom.equalTo(usernameTextField.snp.top).offset(-8.0)
        }
    }

    private func changeCredentialsButtonLayout(){
        addSubview(changeCredentialsButton)
        
        changeCredentialsButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-16.0)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(256.0)
        }
    }
}

extension ProfileView {
    @objc private func didTapLogOutButton(sender: UIButton) {
        delegate?.didTapLogOutButton(sender: sender)
    }
    
    @objc private func didTapChangeUserCredentials(sender: UIButton){
        delegate?.didTapChangeUserCredentials(sender: sender)
    }
    
    @objc private func didTapChangeButton(sender: UIButton) {
        delegate?.didTapChangeButton(sender: sender)
    }
    
    @objc private func didImageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        delegate?.didImageTapped(tapGestureRecognizer: tapGestureRecognizer)
    }
}
