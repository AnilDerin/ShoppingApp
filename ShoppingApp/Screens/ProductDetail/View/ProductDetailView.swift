//
//  ProductDetailView.swift
//  ShoppingApp
//
//  Created by Bartu Gençcan on 31.10.2022.
//

import UIKit
import Cosmos

protocol ProductDetailViewDelegate: AnyObject {
    func didTapAddToBasketButton(button: UIButton)
}

class ProductDetailView: UIView {
    
    // MARK: - Props
    weak var delegate: ProductDetailViewDelegate?
    
    var title: String? {
        didSet {
            productTitleLabel.text = title
        }
    }
    
    var price: String? {
        didSet {
            productPriceLabel.text = price
        }
    }
    
    var productDescription: String? {
        didSet {
            productDescriptionLabel.text = productDescription
        }
    }
    
    var rating: Double? {
        didSet {
            productRating.rating = rating ?? 0
        }
    }
    
    private(set) lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var productTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.sizeToFit()
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = 300
        return label
    }()
    
    private lazy var productPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        return label
    }()
    
    private lazy var productRating: CosmosView = {
        let view = CosmosView()
        view.settings.updateOnTouch = false
        view.settings.starSize = 15
        view.settings.fillMode = .precise
        return view
    }()
    
    private lazy var productDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var addToBasketButton: UIButton = {
       let button = UIButton()
        button.setTitle("Add To Basket", for: .normal)
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 24.0
        button.addTarget(self, action: #selector(didTapAddToBasketButton(_ :)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect){
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setupProductImageView()
        setupProductPriceLabel()
        setupProductTitleLabel()
        setupProductRatingView()
        setupProductDescriptionLabel()
        setupAddToBasketButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setupProductImageView(){
        addSubview(productImageView)
        
        productImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(32.0)
            make.size.equalTo(256.0)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
    
    private func setupProductPriceLabel(){
        addSubview(productPriceLabel)
        productPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(32.0)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
    
    private func setupProductTitleLabel(){
        addSubview(productTitleLabel)
        productTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(productPriceLabel.snp.bottom).offset(16.0)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
    
    private func setupProductRatingView(){
        addSubview(productRating)
        productRating.snp.makeConstraints { make in
            make.top.equalTo(productTitleLabel.snp.bottom).offset(8.0)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
    
    private func setupProductDescriptionLabel(){
        addSubview(productDescriptionLabel)
        productDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(productRating.snp.bottom).offset(16.0)
            make.leading.equalTo(self.snp.leading).offset(16.0)
            make.trailing.equalTo(self.snp.trailing).offset(-16.0)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
    
    private func setupAddToBasketButton(){
        addSubview(addToBasketButton)
        addToBasketButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-16.0)
            make.leading.equalTo(self.snp.leading).offset(32.0)
            make.trailing.equalTo(self.snp.trailing).offset(-32.0)
            make.height.equalTo(48.0)
        }
    }
    
    @objc
    private func didTapAddToBasketButton(_ sender: UIButton) {
        delegate?.didTapAddToBasketButton(button: sender)
    }
}
