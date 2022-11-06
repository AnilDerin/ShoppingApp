//
//  ProductsViewController.swift
//  ShoppingApp
//
//  Created by Bartu Gençcan on 30.10.2022.
//

import UIKit
import Kingfisher

class ProductsViewController: UIViewController {
    // MARK: - Props
    
    private var viewModel: ProductsViewModel
    
    private let cellInset: CGFloat = 8.0
    private let cellMultiplier: CGFloat = 0.5
    private var cellDimension: CGFloat {
        .screenWidth * cellMultiplier - cellInset
    }
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: cellDimension, height: cellDimension)
        return flowLayout
    }()
    
    private(set) lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    

    // MARK: - Init
    init(viewModel: ProductsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        collectionView.register(ProductsCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        setupCollectionViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionViewDelegate(self, andDataSource: self)
        
        
        fetchProducts()
        
        // Handling data
        viewModel.changeHandler = { change in
            switch change {
            case .didFetchProducts:
                self.collectionView.reloadData()
            case .didErrorOccurred(let error):
                print(String(describing: error))
            }
        }
    }
    
    // MARK: - CollectionView Layout
    private func setupCollectionViewLayout(){
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading)
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
            make.trailing.equalTo(view.snp.trailing)
        }
    }
   
    
    func setCollectionViewDelegate(_ delegate: UICollectionViewDelegate, andDataSource dataSource: UICollectionViewDataSource){
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
    }
    
    func refresh(){
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func fetchProducts(){
        viewModel.fetchProducts()
    }
    
    
}

// MARK: - UICollectionViewDelegate
extension ProductsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let product = viewModel.productForIndexPath(indexPath) else {
            return
        }
        let viewModel = ProductDetailViewModel(product: product)
        let productDetailVC = ProductDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension ProductsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductsCollectionViewCell
        
        guard let product = viewModel.productForIndexPath(indexPath) else {
            fatalError("Product not found.")
        }
            // Setting product image in cell
            cell.imageView.kf.setImage(with: URL(string: "\(product.image ?? "")")) { _ in
                collectionView.reloadItems(at: [indexPath])
            }
            
            // Setting product title in cell
            if product.title?.count ?? 0 > 20 {
                cell.title = "\(product.title?.maxLength(length: 20) ?? "")..."
            }else {
                cell.title = product.title
            }
            
            // Setting product price in cell
            cell.price = product.price
            
            // Setting product rating
            cell.rating = product.rating?.rate

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
}

