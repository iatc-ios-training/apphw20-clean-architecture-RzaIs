//
//  ProductDetailsViewController.swift
//  presenter
//
//  Created by Rza Ismayilov on 05.08.22.
//

import Foundation
import UIKit
import SnapKit
import domain

class ProductDetailsViewController: UIViewController {
    
    private lazy var containerView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 8
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Products Details"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        self.view.addSubview(label)
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        self.containerView.addSubview(label)
        return label
    }()
    
    private lazy var colorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        self.containerView.addSubview(label)
        return label
    }()
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        self.containerView.addSubview(label)
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        self.containerView.addSubview(label)
        return label
    }()
    private lazy var materialLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        self.containerView.addSubview(label)
        return label
    }()
    
    private lazy var imageContainerView: UIStackView = {
        let view = UIStackView()
        self.containerView.addSubview(view)
        return view
    }()
    
    private lazy var imageView: UIImageView = .init()
    
    public func setupView(product: ProductEntity) {
        self.view.backgroundColor = .white
        
        self.nameLabel.text = "name: \(product.name)"
        self.colorLabel.text = "color: \(product.color)"
        self.priceLabel.text = "price: \(product.price)$"
        self.descriptionLabel.text = "description: \(product.information)"
        self.materialLabel.text = "material: \(product.material)"
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(8)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-8)
        }
        
        self.containerView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(8)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(8)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-8)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-8)
        }
        
        self.nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.containerView.contentLayoutGuide.snp.top).offset(8)
            make.left.equalTo(self.containerView.contentLayoutGuide.snp.left).offset(8)
            make.right.equalTo(self.containerView.contentLayoutGuide.snp.right).offset(-8)
            make.width.equalTo(self.containerView.safeAreaLayoutGuide.snp.width).offset(-16)
        }
        
        self.colorLabel.snp.makeConstraints { make in
            make.top.equalTo(self.nameLabel.snp.bottom).offset(8)
            make.left.equalTo(self.containerView.contentLayoutGuide.snp.left).offset(8)
            make.right.equalTo(self.containerView.contentLayoutGuide.snp.right).offset(-8)
            make.width.equalTo(self.containerView.safeAreaLayoutGuide.snp.width).offset(-16)
        }
        
        self.priceLabel.snp.makeConstraints { make in
            make.top.equalTo(self.colorLabel.snp.bottom).offset(8)
            make.left.equalTo(self.containerView.contentLayoutGuide.snp.left).offset(8)
            make.right.equalTo(self.containerView.contentLayoutGuide.snp.right).offset(-8)
            make.width.equalTo(self.containerView.safeAreaLayoutGuide.snp.width).offset(-16)
        }
        
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.priceLabel.snp.bottom).offset(8)
            make.left.equalTo(self.containerView.contentLayoutGuide.snp.left).offset(8)
            make.right.equalTo(self.containerView.contentLayoutGuide.snp.right).offset(-8)
            make.width.equalTo(self.containerView.safeAreaLayoutGuide.snp.width).offset(-16)
            make.width.equalTo(self.containerView.safeAreaLayoutGuide.snp.width).offset(-16)
        }
        
        self.materialLabel.snp.makeConstraints { make in
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(8)
            make.left.equalTo(self.containerView.contentLayoutGuide.snp.left).offset(8)
            make.right.equalTo(self.containerView.contentLayoutGuide.snp.right).offset(-8)
            make.width.equalTo(self.containerView.safeAreaLayoutGuide.snp.width).offset(-16)

        }
        
        self.imageContainerView.snp.makeConstraints { make in
            make.top.equalTo(self.materialLabel.snp.bottom).offset(8)
            make.left.equalTo(self.containerView.contentLayoutGuide.snp.left).offset(8)
            make.right.equalTo(self.containerView.contentLayoutGuide.snp.right).offset(-8)
            make.bottom.equalTo(self.containerView.contentLayoutGuide.snp.bottom).offset(-8)
            make.width.equalTo(self.containerView.safeAreaLayoutGuide.snp.width).offset(-16)
        }
        
        
        Task {
            if let image = self.getImage(url: product.image) {
                self.imageView.image = image
                self.imageContainerView.addSubview(self.imageView)
                self.imageView.snp.makeConstraints { make in
                    make.width.height.equalTo(self.imageContainerView.snp.width)
                }
            }
        }
    }
    
    func getImage(url: URL) -> UIImage? {
        do {
            let imageData = try Data(contentsOf: url)
            let image = UIImage(data: imageData)
            return image
        } catch {
            return nil
        }
    }
}
