//
//  BasketTableViewCell.swift
//  ShoppingApp
//
//  Created by Bartu Gençcan on 5.11.2022.
//

import UIKit

protocol BasketTableViewCellDelegate: AnyObject {
    func didTapStepper(stepper: UIStepper)
}

class BasketTableViewCell: UITableViewCell {
    
    weak var delegate: BasketTableViewCellDelegate?
    
    var observation: NSKeyValueObservation?
    
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
        return label
    }()
    
    private lazy var productPriceLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        return label
    }()
    
    private(set) lazy var stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 0
        stepper.addTarget(self, action: #selector(didTapStepper), for: .valueChanged)
        return stepper
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        productImageViewLayout()
        productTitleLabelLayout()
        productPriceLabelLayout()
        stepperLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    func productImageViewLayout(){
        addSubview(productImageView)
        
        productImageView.snp.makeConstraints { make in
            make.leading.equalTo(8.0)
            make.centerY.equalTo(self.snp.centerY)
            make.size.equalTo(128.0)
        }
    }
    
    func productTitleLabelLayout(){
        addSubview(productTitleLabel)
        
        productTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(16.0)
            make.leading.equalTo(productImageView.snp.leading).offset(16.0)
        }
    }
    
    func productPriceLabelLayout(){
        addSubview(productPriceLabel)
        
        productPriceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom).offset(-16.0)
            make.trailing.equalTo(self.snp.trailing).offset(-96.0)
        }
    }
    
    func stepperLayout(){
        contentView.addSubview(stepper)
        
        stepper.snp.makeConstraints { make in
            make.leading.equalTo(productPriceLabel.snp.trailing).offset(-8.0)
            make.centerY.equalTo(productPriceLabel.snp.centerY)
        }
    }
    
}

extension BasketTableViewCell: BasketTableViewCellDelegate {
    @objc func didTapStepper(stepper: UIStepper) {
        delegate?.didTapStepper(stepper: stepper)
    }

}
