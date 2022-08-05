//
//  ProductRemoteDataSource.swift
//  data
//
//  Created by Rza Ismayilov on 02.08.22.
//

import Foundation

public class ProductRemoteDataSource: ProductRemoteDataSourceProtocol {
    
    private let endpoint: String
    private let networkProviderProtocol: NetworkProviderProtocol
    
    init(endpoint: String, networkProviderProtocol: NetworkProviderProtocol) {
        self.endpoint = endpoint
        self.networkProviderProtocol = networkProviderProtocol
    }
    
    public func getProducts() async throws -> [ProductRemoteDTO] {
        return try await self.networkProviderProtocol.request(endpoint: self.endpoint)
    }
    
}
