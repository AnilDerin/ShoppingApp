//
//  UIImage+Extensions.swift
//  ShoppingApp
//
//  Created by Bartu Gençcan on 4.11.2022.
//

import Foundation
import UIKit

extension UIImage {
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
