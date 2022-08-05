//
//  DatabaseProvider.swift
//  data
//
//  Created by Rza Ismayilov on 03.08.22.
//

import Foundation
import RealmSwift
import Realm

class DatabaseProvider: DatabaseProviderProtocol {
    
    private let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func read<T: Object>() -> [T] {
        self.realm.objects(T.self)
            .freeze()
            .map { $0 } as [T]
    }
    
    func write<T: Object>(objects: [T]) throws {
        try self.realm.write {
            self.realm.add(objects, update: .modified)
        }
    }
    
    func delete<T: Object>(type: T.Type) throws {
        let objects = self.realm.objects(type)
        try self.realm.write {
            self.realm.delete(objects)
        }
    }
    
    func deleteAll() throws {
        try self.realm.write {
            self.realm.deleteAll()
        }
    }
}
