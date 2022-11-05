//
//  BasketViewModel.swift
//  ShoppingApp
//
//  Created by Bartu Gençcan on 5.11.2022.
//

import Foundation
import FirebaseFirestore

final class BasketViewModel {
    
    private var products = [Product]()
    
    let defaults = UserDefaults.standard
    
    let db = Firestore.firestore()
    
    
    var numberOfRows: Int {
        products.count
    }
    
    func productForIndexPath(_ indexPath: IndexPath) -> Product? {
        products[indexPath.row]
    }
    
    func fetchProducts(_ completion: @escaping (Error?) -> Void) {
        
        products = []
        
        guard let uid = defaults.string(forKey: "uid") else {
            return
        }
        
        db.collection("users").document(uid).getDocument() { (querySnapshot, err) in
            guard let data = querySnapshot?.data() else {
                return
            }

            let user = User(from: data)


            user.basket?.forEach({ productId in
                self.db.collection("products").document(productId).getDocument { (querySnapshot, err) in
                    if let err = err {
                        completion(err)
                    } else {
                        guard let data = querySnapshot?.data() else {
                            return
                        }
                        let product = Product(from: data)
                        self.products.append(product)
                        completion(nil)
                    }
                }
            })
        }
    }
}
