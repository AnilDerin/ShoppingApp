//
//  OnboardViewController.swift
//  ShoppingApp
//
//  Created by Bartu Gençcan on 24.10.2022.
//

import UIKit

class OnboardViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: heroImageName)
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let titleText: String
    let heroImageName: String
    let descriptionText: String

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        titleLabelLayout()
        imageViewLayout()
        descriptionLabelLayout()
    }
    
    override func viewDidLayoutSubviews() {
        imageViewStyle()
        titleLabelStyle()
        descriptionLabelStyle()
    }
    
    init(heroImageName: String, titleText: String, descriptonText: String) {
        self.heroImageName = heroImageName
        self.titleText = titleText
        self.descriptionText = descriptonText
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnboardViewController {
    
    private func titleLabelStyle(){
        titleLabel.text = titleText
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
    }
    
    private func titleLabelLayout(){
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(128.0)
            make.centerX.equalTo(view.snp.centerX)
        }
        
    }
    
    private func imageViewStyle(){
        let radius = CGRectGetWidth(imageView.frame) / 2
        imageView.layer.cornerRadius = radius
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.black.cgColor
    }
    
    private func imageViewLayout(){
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(32.0)
            make.size.equalTo(240.0)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
    
    private func descriptionLabelStyle(){
        descriptionLabel.text = descriptionText
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .callout)
    }
    
    private func descriptionLabelLayout(){
        view.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(32.0)
            make.leading.equalTo(view.snp.leading).offset(16.0)
            make.trailing.equalTo(view.snp.trailing).offset(-16.0)
        }
    }
}
