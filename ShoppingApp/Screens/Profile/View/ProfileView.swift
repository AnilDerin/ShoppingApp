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
        return imageView
    }()
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.backgroundColor = .systemOrange
        button.addTarget(self, action: #selector(didTapLogOutButton), for: .touchUpInside)
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
}

extension ProfileView {
    @objc private func didTapLogOutButton(sender: UIButton) {
        delegate?.didTapLogOutButton(sender: sender)
    }
}
