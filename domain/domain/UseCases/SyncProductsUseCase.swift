//
//  SyncProductsUseCase.swift
//  domain
//
//  Created by Rza Ismayilov on 02.08.22.
//

import Foundation

public class SyncProductsUseCase {
    private let productRepo: ProductRepoProtocol
    
    init(productRepo: ProductRepoProtocol) {
        self.productRepo = productRepo
    }
    
    public func execute() async throws {
        try await self.productRepo.syncProducts()
    }
}
