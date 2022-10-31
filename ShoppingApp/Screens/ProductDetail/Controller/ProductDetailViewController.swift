//
//  ProductDetailViewController.swift
//  ShoppingApp
//
//  Created by Bartu Gençcan on 30.10.2022.
//

import UIKit
import Kingfisher

class ProductDetailViewController: UIViewController{
    private lazy var productDetailView: ProductDetailView = {
        let view = ProductDetailView()
        view.delegate = self
        return view
    }()
    
    private var viewModel: ProductDetailViewModel
    
    init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Product Detail"
        view = productDetailView
        
        viewModel.delegate = self
        
        productDetailView.productImageView.kf.setImage(with: viewModel.imageURL)
        productDetailView.title = viewModel.title
        productDetailView.rating = viewModel.rating
        productDetailView.productDescription = viewModel.description
        productDetailView.price = "\(viewModel.price ?? 0) $"
        
        view.backgroundColor = .white
    }
}

// MARK: - ProductDetailDelegate
extension ProductDetailViewController: ProductDetailDelegate, AlertPresentable {
    func didProductAddedToBasket() {
        NotificationCenter().post(name: NSNotification.Name("didAnyCoinAddedToFavorites"), object: nil)
        showAlert(title: "Info", message: "Product added to your basket!",  handler: nil)
    }
}

// MARK: - ProductDetailViewDelegate
extension ProductDetailViewController: ProductDetailViewDelegate {
    func didTapAddToBasketButton(button: UIButton) {
        viewModel.addToBasket()
    }
}
