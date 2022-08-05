//
//  ProductLocalDataSources.swift
//  data
//
//  Created by Rza Ismayilov on 02.08.22.
//

import Foundation
import RealmSwift
import RxSwift
import RxRelay

class ProductLocalDataSources: ProductLocalDataSourcesProtocol {
    
    private let databaseProviderProtocol: DatabaseProviderProtocol
    private let productRelay: BehaviorRelay<[ProductLocalDTO]> = .init(value: [])
    
    init(databaseProviderProtocol: DatabaseProviderProtocol) {
        self.databaseProviderProtocol = databaseProviderProtocol
        self.productRelay.accept(self.getProducts())
    }
    
    func deleteProducts() throws {
        self.productRelay.accept([])
        try self.databaseProviderProtocol.delete(type: ProductLocalDTO.self)
    }
    
    func getProducts() -> [ProductLocalDTO] {
        return self.databaseProviderProtocol.read()
    }
    
    func observeProducts() -> Observable<[ProductLocalDTO]> {
        return productRelay.asObservable()
    }
    
    func save(products: [ProductLocalDTO]) throws {
        try self.databaseProviderProtocol.delete(type: ProductLocalDTO.self)
        try self.databaseProviderProtocol.write(objects: products)
        self.productRelay.accept(products)
    }
}
