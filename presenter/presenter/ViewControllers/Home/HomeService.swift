//
//  HomeService.swift
//  presenter
//
//  Created by Rza Ismayilov on 05.08.22.
//

import Foundation
import UIKit
import RxSwift
import domain
import RxRelay

class HomeService {
    
    private let disposeBag: DisposeBag = .init()
    
    private lazy var products: [ProductEntity] = {
        return self.getProductsUseCase.execute()
    }()
    
    private let alertRelay: BehaviorRelay<(String, String)?> = .init(value: nil)
    
    private let observeProductsUseCase: ObserveProductsUseCase
    private let syncProductsUseCase: SyncProductsUseCase
    private let getProductsUseCase: GetProductsUseCase
    
    init(observeProductsUseCase: ObserveProductsUseCase,
         syncProductsUseCase: SyncProductsUseCase,
         getProductsUseCase: GetProductsUseCase) {
        self.observeProductsUseCase = observeProductsUseCase
        self.syncProductsUseCase = syncProductsUseCase
        self.getProductsUseCase = getProductsUseCase
    }
    
    public var Disposer: DisposeBag {
        self.disposeBag
    }
    
    public var Products: [ProductEntity] {
        get {
            return self.products
        } set {
            self.products = newValue
        }
    }
    
    func observeProducts() -> Observable<[ProductEntity]> {
        self.observeProductsUseCase.execute()
    }
    
    func observeAlerts() -> Observable<(String, String)> {
        self.alertRelay.filter { $0 != nil }
            .map { $0! }
            .asObservable()
    }
    
    func syncProducts() {
        Task {
            do {
                try await self.syncProductsUseCase.execute()
            } catch {
                self.alertRelay.accept(("Connection Error", "Cannot fetch Products"))
            }
        }
    }
}
