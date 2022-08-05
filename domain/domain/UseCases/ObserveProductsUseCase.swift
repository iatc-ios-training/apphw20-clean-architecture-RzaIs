//
//  ObserveProductsUseCase.swift
//  domain
//
//  Created by Rza Ismayilov on 02.08.22.
//

import Foundation
import RxSwift

public class ObserveProductsUseCase {
    private let productRepo: ProductRepoProtocol
    
    public init(productRepo: ProductRepoProtocol) {
        self.productRepo = productRepo
    }
    
    public func execute() -> Observable<[ProductEntity]>  {
        return self.productRepo.observeProducts()
    }
}
