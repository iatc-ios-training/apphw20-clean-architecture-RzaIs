//
//  NetworkProvider.swift
//  data
//
//  Created by Rza Ismayilov on 02.08.22.
//

import Foundation
import Alamofire

class NetworkProvider: NetworkProviderProtocol {
    
    let baseURL: String
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    func request<T: Decodable>(endpoint: String) async throws -> T {
        return try await withUnsafeThrowingContinuation { continuation in
            let url = "\(baseURL)/\(endpoint)"
            AF.request(url, method: .get)
                .responseDecodable(of: T.self) { response in
                    if let error = response.error {
                        continuation.resume(throwing: error)
                    } else if let data = response.value {
                        continuation.resume(returning: data)
                    } else {
                        continuation.resume(throwing: DataError(msg: "Decoding-Error"))
                    }
                }
        }
    }
    
    
}

public struct DataError: Error {
    let msg: String
    
    public init(msg: String) {
        self.msg = msg
    }
}
