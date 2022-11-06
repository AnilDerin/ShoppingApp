//
//  BasketTableViewCell.swift
//  ShoppingApp
//
//  Created by Bartu Gençcan on 5.11.2022.
//

import UIKit


class BasketTableViewCell: UITableViewCell {
    
    
    var productTitle: String? {
        didSet {
            productTitleLabel.text = productTitle
        }
    }
    
    var productPrice: Double? {
        didSet {
            productPriceLabel.text = "\(productPrice ?? 0) $"
        }
    }
    

    private(set) lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var productTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = 300
        return label
    }()
    
    private lazy var productPriceLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        productTitleLabelLayout()
        productImageViewLayout()
        productPriceLabelLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    func productTitleLabelLayout(){
        addSubview(productTitleLabel)
        
        productTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(16.0)
            make.leading.equalTo(16.0)
        }
    }
    
    func productImageViewLayout(){
        addSubview(productImageView)
        
        productImageView.snp.makeConstraints { make in
            make.leading.equalTo(8.0)
            make.top.equalTo(productTitleLabel.snp.bottom).offset(16.0)
            make.size.equalTo(128.0)
        }
    }
    
    func productPriceLabelLayout(){
        addSubview(productPriceLabel)
        
        productPriceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom).offset(-16.0)
            make.trailing.equalTo(self.snp.trailing).offset(-24.0)
        }
    }
    
    
}

