//
//  dataDI.swift
//  data
//
//  Created by Rza Ismayilov on 02.08.22.
//

import Foundation
import Swinject
import domain
import RealmSwift

public class DataDI: Assembly {
    
    private let baseURL: String
    
    public init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    public func assemble(container: Container) {
        
        container.register(Realm.self) { r in
            let config = Realm.Configuration(
                schemaVersion: 1,
                deleteRealmIfMigrationNeeded: true
            )
            return try! Realm(configuration: config)
        }.inObjectScope(.container)
        
        container.register(DatabaseProviderProtocol.self) { r in
            return DatabaseProvider(realm: r.resolve(Realm.self)!)
        }.inObjectScope(.container)
        
        container.register(ProductRemoteDataSourceProtocol.self) { r in
            return ProductRemoteDataSource(
                endpoint: "product",
                networkProviderProtocol: r.resolve(NetworkProviderProtocol.self)!
            )
        }.inObjectScope(.container)
        
        container.register(ProductLocalDataSourcesProtocol.self) { r in
            return ProductLocalDataSources(databaseProviderProtocol: r.resolve(DatabaseProviderProtocol.self)!)
        }.inObjectScope(.container)
        
        container.register(NetworkProviderProtocol.self) { _ in
            return NetworkProvider(baseURL: self.baseURL)
        }.inObjectScope(.container)
        
        container.register(ProductRepoProtocol.self) { r in
            return ProductRepo(
                localDataSource: r.resolve(ProductLocalDataSourcesProtocol.self)!,
                remoteDataSource: r.resolve(ProductRemoteDataSourceProtocol.self)!
            )
        }.inObjectScope(.container)
    }
}
