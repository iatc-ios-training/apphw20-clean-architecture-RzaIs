//
//  PresenterDI.swift
//  presenter
//
//  Created by Rza Ismayilov on 03.08.22.
//

import Foundation
import Swinject
import domain

public class PresenterDI: Assembly {
        
    public init() {}
    
    public func assemble(container: Container) {
        
        container.register(HomeService.self) { r in
            HomeService(
                observeProductsUseCase: r.resolve(ObserveProductsUseCase.self)!,
                syncProductsUseCase: r.resolve(SyncProductsUseCase.self)!,
                getProductsUseCase: r.resolve(GetProductsUseCase.self)!
            )
        }
        
        container.register(HomeViewController.self) { r in
            return HomeViewController(service: r.resolve(HomeService.self)!)
        }
    }
}
