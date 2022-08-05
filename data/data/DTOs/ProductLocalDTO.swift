//
//  ProductLocalDTO.swift
//  data
//
//  Created by Rza Ismayilov on 02.08.22.
//

import Foundation
import RealmSwift

class ProductLocalDTO: Object {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var name: String = ""
    @Persisted var color: String = ""
    @Persisted var price: Double = 0.0
    @Persisted var information: String = ""
    @Persisted var material: String = ""
    @Persisted var image: String = ""
    
    convenience init(
        id: String,
        name: String,
        color: String,
        price: Double,
        information: String,
        material: String,
        image: String
    ) {
        self.init()
        self.id = id
        self.name = name
        self.color = color
        self.price = price
        self.information = information
        self.material = material
        self.image = image
    }
}
