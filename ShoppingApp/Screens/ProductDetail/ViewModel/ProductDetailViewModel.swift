//
//  ProductDetailViewModel.swift
//  ShoppingApp
//
//  Created by Bartu Gençcan on 30.10.2022.
//

import Foundation
import FirebaseFirestore

@objc
protocol ProductDetailDelegate: AnyObject {
    @objc optional func didProductAddedToBasket()
}

class ProductDetailViewModel {
    weak var delegate: ProductDetailDelegate?
    
    private let db = Firestore.firestore()
    
    private let defaults = UserDefaults.standard
    
    private var product: Product
    
    var title: String? {
        product.title
    }
    
    var price: Double? {
        product.price
    }
    
    var rating: Double? {
        product.rating?.rate
    }
    
    var imageURL: URL? {
        URL(string: product.image ?? "")
    }
    
    var description: String? {
        product.productDescription
    }
    
    init(product: Product) {
        self.product = product
    }
    
    func addToBasket(){
        
        
        
        guard let id = product.id,
              let uid = defaults.string(forKey: "uid") else {return}
        
        db.collection("users").document(uid).updateData([
            "basket": FieldValue.arrayUnion([id])
        ])
        
        delegate?.didProductAddedToBasket?()
    }
}
