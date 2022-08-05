//
//  ProductLocalDataSourcesProtocol.swift
//  data
//
//  Created by Rza Ismayilov on 02.08.22.
//

import Foundation
import RxSwift

protocol ProductLocalDataSourcesProtocol {
    func deleteProducts() throws
    func getProducts() -> [ProductLocalDTO]
    func observeProducts() -> Observable<[ProductLocalDTO]>
    func save(products: [ProductLocalDTO]) throws
}
