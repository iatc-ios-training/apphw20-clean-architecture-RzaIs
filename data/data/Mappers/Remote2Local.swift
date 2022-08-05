//
//  Remote2Local.swift
//  data
//
//  Created by Rza Ismayilov on 02.08.22.
//

import Foundation

extension ProductRemoteDTO {
    func toLocal() -> ProductLocalDTO {
        
        let price = Double(self.price) ?? 0.0
        
        return ProductLocalDTO(
            id: self.id,
            name: self.name,
            color: self.color,
            price: price,
            information: self.information,
            material: self.material,
            image: image
        )
    }
}
