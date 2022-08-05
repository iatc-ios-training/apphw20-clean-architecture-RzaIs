//
//  Productrepo.swift
//  data
//
//  Created by Rza Ismayilov on 02.08.22.
//

import Foundation
import RxSwift
import domain


public class ProductRepo: ProductRepoProtocol {
    
    private let localDataSource: ProductLocalDataSourcesProtocol
    private let remoteDataSource: ProductRemoteDataSourceProtocol
    
    init(localDataSource: ProductLocalDataSourcesProtocol,
         remoteDataSource: ProductRemoteDataSourceProtocol
    ) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }
    
    public func syncProducts() async throws {
        let productLocalDTOs = try await self.remoteDataSource.getProducts()
            .map { productRemoteDTO in
                DispatchQueue.main.sync {
                    productRemoteDTO.toLocal()
                }
                
            }
        try DispatchQueue.main.sync {
            try self.localDataSource.save(products: productLocalDTOs)
        }
    }
    
    public func getProducts() -> [ProductEntity] {
        return self.localDataSource.getProducts()
            .map { $0.toDomain() }
    }

    public func observeProducts() -> Observable<[ProductEntity]> {
        self.localDataSource.observeProducts()
            .map { productLocalDTOs in
                productLocalDTOs.map { productLocalDTO in
                    productLocalDTO.toDomain()
                }
            }
    }
    
    public func cleanCache() throws {
        try self.localDataSource.deleteProducts()
    }
    
}
