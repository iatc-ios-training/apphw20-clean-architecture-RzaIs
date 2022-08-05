//
//  DatabaseProviderProtocol.swift
//  data
//
//  Created by Rza Ismayilov on 03.08.22.
//

import Foundation
import RealmSwift

protocol DatabaseProviderProtocol {
    func read<T: Object>() -> [T]
    func write<T: Object>(objects: [T]) throws
    func delete<T: Object>(type: T.Type) throws
    func deleteAll() throws
}
