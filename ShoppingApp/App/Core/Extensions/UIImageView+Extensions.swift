//
//  UIImage+Extensions.swift
//  ShoppingApp
//
//  Created by Bartu Gençcan on 31.10.2022.
//

import UIKit

extension UIImageView {

    func roundedImage(imageView: UIImageView) {
        let radius = imageView.frame.size.width / 2
        imageView.layer.cornerRadius = radius
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.black.cgColor
    }
    
}
