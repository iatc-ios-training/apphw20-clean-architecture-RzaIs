//
//  ProductRemoteDataSourceProtocol.swift
//  data
//
//  Created by Rza Ismayilov on 02.08.22.
//

import Foundation

protocol ProductRemoteDataSourceProtocol {
    func getProducts() async throws -> [ProductRemoteDTO]
}
