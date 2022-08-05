//
//  ProductEntity.swift
//  domain
//
//  Created by Rza Ismayilov on 02.08.22.
//

import Foundation

public struct ProductEntity {
    public let id: String
    public let name: String
    public let color: String
    public let price: Double
    public let information: String
    public let material: String
    public let image: URL
    
    public init(
        id: String,
        name: String,
        color: String,
        price: Double,
        information: String,
        material: String,
        image: URL
    ) {       
        self.id = id
        self.name = name
        self.color = color
        self.price = price
        self.information = information
        self.material = material
        self.image = image
    }
}


