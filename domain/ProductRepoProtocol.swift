//
//  ProductRepoProtocol.swift
//  domain
//
//  Created by Rza Ismayilov on 02.08.22.
//

import Foundation
import RxSwift

public protocol ProductRepoProtocol {
    func syncProducts() async throws
    func getProducts() -> [ProductEntity]
    func observeProducts() -> Observable<[ProductEntity]>
    func cleanCache() throws
}
