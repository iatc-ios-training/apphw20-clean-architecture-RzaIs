//
//  ProductCellView.swift
//  presenter
//
//  Created by Rza Ismayilov on 05.08.22.
//

import Foundation
import SnapKit
import UIKit

class ProductCellView: UITableViewCell {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 16
        self.contentView.addSubview(view)
        return view
    }()
    
    private lazy var imageContainerView: UIStackView = {
        let view = UIStackView()
        self.containerView.addSubview(view)
        return view
    }()
    
    private lazy var productImage: UIImageView = .init()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        self.containerView.addSubview(label)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        self.containerView.addSubview(label)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        self.containerView.addSubview(label)
        return label
    }()
    
    public func setup(name: String, description: String, price: Double, url: URL) {
        
        self.selectionStyle = .none
        
        self.nameLabel.text = name
        self.descriptionLabel.text = description
        self.priceLabel.text = "\(price) $"
        
        self.containerView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(4)
            make.right.bottom.equalToSuperview().offset(-4)
        }
        
        self.imageContainerView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        self.nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(72)
            make.bottom.equalTo(self.containerView.snp.centerY)
            make.right.lessThanOrEqualTo(self.priceLabel.snp.left).offset(8)
        }
        
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.containerView.snp.centerY)
            make.left.equalTo(self.nameLabel.snp.left)
            make.bottom.equalToSuperview().offset(-16)
            make.right.equalToSuperview().offset(-8)
        }
        
        self.priceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalTo(self.containerView.snp.centerY)
        }
        
        
        Task(priority: .background) {
            if let image = self.getImage(url: url) {
                self.productImage.image = image
                self.imageContainerView.addSubview(self.productImage)
                self.productImage.snp.makeConstraints { make in
                    make.width.height.equalTo(48)
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
