//
//  domainDI.swift
//  domain
//
//  Created by Rza Ismayilov on 02.08.22.
//

import Foundation
import Swinject

public class DomainDI: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        
        container.register(SyncProductsUseCase.self) { r in
            return SyncProductsUseCase(productRepo: r.resolve(ProductRepoProtocol.self)!)
        }
        
        container.register(ObserveProductsUseCase.self) { r in
            return ObserveProductsUseCase(productRepo: r.resolve(ProductRepoProtocol.self)!)
        }
        
        container.register(GetProductsUseCase.self) { r in
            return GetProductsUseCase(productRepo: r.resolve(ProductRepoProtocol.self)!)
        }
    }
}
