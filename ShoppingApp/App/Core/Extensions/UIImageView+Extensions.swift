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
    
    public static func loadFrom(url: URL, completion: @escaping (_ image: UIImage?) -> ()) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        completion(UIImage(data: data))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
        }
}
