//
//  ProductRemoteDTO.swift
//  data
//
//  Created by Rza Ismayilov on 02.08.22.
//

import Foundation

public struct ProductRemoteDTO: Decodable {
    public let id: String
    public let name: String
    public let color: String
    public let price: String
    public let information: String
    public let material: String
    public let image: String
    
    public enum CodingKeys: String,CodingKey {
        case id, name, color, price, information="description", material, image
    }
}

