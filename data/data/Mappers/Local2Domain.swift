//
//  Local2Domain.swift
//  data
//
//  Created by Rza Ismayilov on 02.08.22.
//

import Foundation
import domain

extension ProductLocalDTO {
    func toDomain() -> ProductEntity {
        
        return ProductEntity(
            id: self.id,
            name: self.name,
            color: self.color,
            price: self.price,
            information: self.information,
            material: self.material,
            image: self.saveImage()
        )
    }
    
    func saveImage() -> URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documents.appendingPathComponent("\(self.id).jpg")
        let imageURLString = self.image
        
        Task(priority: .background) {
            if let remoteURL = URL(string: imageURLString) {
                let imageData = try Data(contentsOf: remoteURL)
                try imageData.write(to: url)
            }
        }
        
        return url
    }
}
