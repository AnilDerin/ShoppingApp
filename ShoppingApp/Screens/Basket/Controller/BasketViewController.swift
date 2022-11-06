//
//  BasketViewController.swift
//  ShoppingApp
//
//  Created by Bartu Gençcan on 30.10.2022.
//

import UIKit
import Kingfisher

class BasketViewController: UIViewController, AlertPresentable {
    
    private let viewModel: BasketViewModel
    
    private lazy var tableView = UITableView()
    
    private var isAnyProductAddedToBasket: Bool = true
    
    // MARK: - Init
    init(viewModel: BasketViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        tableView.register(BasketTableViewCell.self, forCellReuseIdentifier: "basketCell")
        setupTableViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableViewDelegate(self, andDataSource: self)
        
        title = "Basket"
        
        NotificationCenter().addObserver(self,
                                         selector: #selector(self.didAnyProductAddedToBasket),
                                         name: NSNotification.Name("didAnyProductAddedToBasket"),
                                         object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isAnyProductAddedToBasket = true
        fetchProducts()
    }
    
    // MARK: - Methods
    private func fetchProducts() {
       if isAnyProductAddedToBasket {
           isAnyProductAddedToBasket = false

        }
        viewModel.fetchProducts { error in
            if let error = error {
                self.showError(error)
            } else {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc private func didAnyProductAddedToBasket() {
        isAnyProductAddedToBasket = true
    }
    
    // MARK: - Layout
    private func setupTableViewLayout(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading)
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
            make.trailing.equalTo(view.snp.trailing)
        }
        
        tableView.rowHeight = 250
    }
    
    //MARK: - TableView Configuration
    func setTableViewDelegate(_ delegate: UITableViewDelegate, andDataSource dataSource: UITableViewDataSource){
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    
    func refresh(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

// MARK: - Tableview Delegate
extension BasketViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Tableview DataSource
extension BasketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "basketCell", for: indexPath) as? BasketTableViewCell else {
            fatalError("Basket Cell not found.")
        }
        
        guard let product = viewModel.productForIndexPath(indexPath) else {
            fatalError("Product not found.")
        }
        
        cell.productTitle = "\(product.title?.maxLength(length: 32) ?? "")..."
        cell.productPrice = product.price
        cell.productImageView.kf.setImage(with: URL(string: "\(product.image ?? "")")) { _ in
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        
        return cell
    }
}

// MARK: - Delegate
