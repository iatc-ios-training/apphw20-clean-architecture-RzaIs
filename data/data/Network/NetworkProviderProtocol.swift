//
//  NetworkProviderProtocol.swift
//  data
//
//  Created by Rza Ismayilov on 02.08.22.
//

import Foundation

protocol NetworkProviderProtocol {
    func request<T: Decodable>(endpoint: String) async throws -> T
}
