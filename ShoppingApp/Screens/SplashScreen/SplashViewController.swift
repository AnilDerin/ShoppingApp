//
//  SplashViewController.swift
//  ShoppingApp
//
//  Created by Bartu Gençcan on 24.10.2022.
//

import UIKit

class SplashViewController: UIViewController {
    
    var activityView: UIActivityIndicatorView?
    
    var logoImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureLogoImageView()
        showActivityIndicator()
        
        // Waits 2 seconds and goes to home screen
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2){
            let onboardVC = OnboardViewController()
            self.navigationController?.setViewControllers([onboardVC], animated: true)
            
            self.activityView?.stopAnimating()
        }
    }
    
    func showActivityIndicator(){
        activityView = UIActivityIndicatorView(style: .large)
        
        guard let activityView = activityView else {return}
        
        self.view.addSubview(activityView)
        
        activityView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(32.0)
            make.centerX.equalTo(logoImageView)
        }
        
        activityView.startAnimating()
    }
    
    func configureLogoImageView(){
        logoImageView = UIImageView(frame: CGRectMake(0, 0, 100, 100))
        logoImageView.image = UIImage(named: "AppIcon")
        
        logoImageView.layer.borderWidth = 1
        logoImageView.layer.masksToBounds = false
        logoImageView.layer.borderColor = UIColor.black.cgColor
        logoImageView.layer.cornerRadius = logoImageView.frame.height / 2
        logoImageView.clipsToBounds = true
        
        self.view.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(360.0)
        }
    }

}
