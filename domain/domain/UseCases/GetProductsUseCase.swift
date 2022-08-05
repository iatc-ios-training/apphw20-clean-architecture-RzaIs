//
//  GetProductsUseCase.swift
//  domain
//
//  Created by Rza Ismayilov on 05.08.22.
//

import Foundation


public class GetProductsUseCase {
    private let productRepo: ProductRepoProtocol
    
    public init(productRepo: ProductRepoProtocol) {
        self.productRepo = productRepo
    }
    
    public func execute() -> [ProductEntity] {
        return self.productRepo.getProducts()
    }
}
