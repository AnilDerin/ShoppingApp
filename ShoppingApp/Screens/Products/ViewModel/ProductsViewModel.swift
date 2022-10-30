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
    
    weak var delegate: BasketProductDelegate?
    
    private let db = Firestore.firestore()
    
    var changeHandler: ((ProductListChanges) -> Void)?
    
    private var productsList: [Product]? {
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
                }catch {
                    self.changeHandler?(.didErrorOccurred(error))
                }
            }
        }
    }
    
    func productForIndexPath(_ indexPath: IndexPath) -> Product? {
        productsList?[indexPath.row]
    }
    
    // Add to basket
    
}
