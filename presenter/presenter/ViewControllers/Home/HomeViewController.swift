//
//  HomeViewController.swift
//  presenter
//
//  Created by Rza Ismayilov on 03.08.22.
//

import UIKit
import SnapKit
import domain

public class HomeViewController: UIViewController {

    private let productCell: String = "PRODUCT_CELL"
    
    private let service: HomeService
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Products"
        self.view.addSubview(label)
        return label
    }()
    
    private lazy var productsTable: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.delegate = self
        view.dataSource = self
        view.register(ProductCellView.self, forCellReuseIdentifier: self.productCell)
        view.separatorStyle = .none
        self.view.addSubview(view)
        return view
    }()
    
    init(service: HomeService) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        self.productsTable.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(4)
            make.left.right.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(4)
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.service.syncProducts()
    
        self.service.observeAlerts().subscribe { event in
            guard let (title, message) = event.element else { return }
            if !Thread.isMainThread {
                DispatchQueue.main.sync {
                    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    let action = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
                        self?.service.syncProducts()
                    }
                    alert.addAction(action)
                    self.present(alert, animated: true)
                }
            }
        }.disposed(by: self.service.Disposer)
        
        self.service.observeProducts().subscribe { event in
            guard let products = event.element else { return }
            self.service.Products = products
            self.productsTable.reloadData()
        }.disposed(by: self.service.Disposer)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.service.Products.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.productCell, for: indexPath) as! ProductCellView
        let info = self.service.Products[indexPath.row]
        cell.setup(name: info.name, description: info.information, price: info.price, url: info.image)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = ProductDetailsViewController()
        let product = self.service.Products[indexPath.row]
        detailVC.setupView(product: product)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
