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
    func productAlreadyInBasket()
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
        get {
            return product.price
        }
        set {
            self.price = newValue
        }
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
        
        let docRef = db.collection("users").document(uid)
        
        docRef.getDocument { document, error in
            guard error == nil, let document = document, document.exists, let basket = document.get("basket") as? [String] else { return }
            if basket.contains(where: {"\($0)" == "\(id)"}){
                self.delegate?.productAlreadyInBasket()
            } else {
                docRef.updateData([
                    "basket": FieldValue.arrayUnion(["\(id)"])
                ])
                
                self.delegate?.didProductAddedToBasket?()
            }
        }

    }
}
