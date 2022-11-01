//
//  SearchViewController.swift
//  ShoppingApp
//
//  Created by Bartu Gençcan on 30.10.2022.
//

import UIKit
import Kingfisher

class SearchViewController: UIViewController {
    
    private var viewModel: ProductsViewModel
    
    // MARK: - Props
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
    
    private lazy var searchBar = UISearchBar()
    
    var searchData = [Product]()
    var searchActive = false

    // MARK: - Init
    init(viewModel: ProductsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        collectionView.register(ProductsCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        setupSearchBar()
        setupCollectionViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionViewDelegate(self, andDataSource: self)
        
        viewModel.fetchProducts()
        
        viewModel.changeHandler = { change in
            switch change {
            case .didFetchProducts:
                self.collectionView.reloadData()
            case .didErrorOccurred(let error):
                print(String(describing: error))
            }
        }
        
               searchBar.searchBarStyle = UISearchBar.Style.prominent
               searchBar.placeholder = " Search..."
               searchBar.sizeToFit()
               searchBar.isTranslucent = false
               searchBar.backgroundImage = UIImage()
               searchBar.delegate = self
               

    }
    
    // MARK: - Methods
    
    private func setupSearchBar(){
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalTo(48.0)
        }
    }
    
    private func setupCollectionViewLayout(){
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading)
            make.top.equalTo(searchBar.snp.bottom).offset(16.0)
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
}

// MARK: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let product = viewModel.productForIndexPath(indexPath) else {
            return
        }
        
        if searchActive {
            let searchedProduct = searchData[indexPath.row]
            let viewModel = ProductDetailViewModel(product: searchedProduct)
            let productDetailVC = ProductDetailViewController(viewModel: viewModel)
            navigationController?.pushViewController(productDetailVC, animated: true)
        }else {
            let viewModel = ProductDetailViewModel(product: product)
            let productDetailVC = ProductDetailViewController(viewModel: viewModel)
            navigationController?.pushViewController(productDetailVC, animated: true)
        }
        
    }
}

// MARK: - UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchActive {
            return searchData.count
        }else {
            return viewModel.numberOfItems
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductsCollectionViewCell
        
        guard let product = viewModel.productForIndexPath(indexPath) else {
            fatalError("Product not found.")
        }
        
        
        
        if searchActive {
            let searchedProduct = searchData[indexPath.row]
            // Setting product image in cell
            cell.imageView.kf.setImage(with: URL(string: "\(searchedProduct.image ?? "")")) { _ in
                collectionView.reloadItems(at: [indexPath])
            }
            
            // Setting product title in cell
            if searchedProduct.title?.count ?? 0 > 20 {
                cell.title = "\(searchedProduct.title?.maxLength(length: 20) ?? "")..."
            }else {
                cell.title = searchedProduct.title
            }
            
            // Setting product price in cell
            cell.price = searchedProduct.price
            
            // Setting product rating
            cell.rating = searchedProduct.rating?.rate
        }else {
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
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
}

// MARK: - UISearchBar
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard let productsList = viewModel.productsList else {return}
        
        searchData = searchText.isEmpty ? productsList : productsList.filter{$0.title?.range(of: searchText, options: [.caseInsensitive, .anchored]) != nil}
        searchActive = true
        
        collectionView.reloadData()
    }
}

