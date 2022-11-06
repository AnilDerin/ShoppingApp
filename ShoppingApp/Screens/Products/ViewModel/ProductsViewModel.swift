//
//  ProductsViewModel.swift
//  ShoppingApp
//
//  Created by Bartu Gençcan on 30.10.2022.
//

import Foundation
import Moya
import FirebaseFirestore

@objc
protocol BasketProductDelegate: AnyObject {
    @objc optional func didErrorOccured(_ error: Error)
    @objc optional func didProductAddedToBasket()
}

// Controlling Changes
enum ProductListChanges {
    case didErrorOccurred(_ error: Error)
    case didFetchProducts
}

class ProductsViewModel {
    
    // MARK: - Properties
    
    weak var delegate: BasketProductDelegate?
    
    private let db = Firestore.firestore()
    
    var changeHandler: ((ProductListChanges) -> Void)?
    
    
    private(set) var productsList: [Product]? {
        didSet {
            self.changeHandler?(.didFetchProducts)
        }
    }
    
    var numberOfItems: Int {
        productsList?.count ?? .zero
    }
    
    // MARK: - Functions
    func fetchProducts(){
        provider.request(.allProducts) { result in
            switch result {
            case .failure(let error):
                self.changeHandler?(.didErrorOccurred(error))
            case .success(let response):
                do {
                    let products = try JSONDecoder().decode([Product].self, from: response.data)
                        self.productsList = products
                    self.addProductsToFirebaseFirestore(self.productsList)
                }catch {
                    self.changeHandler?(.didErrorOccurred(error))
                }
            }
        }
    }
    
    private func addProductsToFirebaseFirestore(_ products: [Product]?) {
            guard let products = products else {
                return
            }
            products.forEach { product in
                do {
                    let data = product.dictionary
                    let id = product.id
                    
                    db.collection("products").document("\(id ?? 0)").setData(data) { error in
                        
                        if let error = error {
                            self.changeHandler?(.didErrorOccurred(error))
                        }
                    }
                }
            }
        }
    
    func productForIndexPath(_ indexPath: IndexPath) -> Product? {
        productsList?[indexPath.row]
    }
    
    
}
