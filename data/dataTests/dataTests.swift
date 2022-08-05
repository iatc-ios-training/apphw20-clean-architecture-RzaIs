//
//  dataTests.swift
//  dataTests
//
//  Created by Rza Ismayilov on 30.07.22.
//

import XCTest
@testable import data

class dataTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() async throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        let np: NetworkProviderProtocol = NetworkProvider(baseURL: "http://0.0.0.0:3001")
        do {
            let response: [ProductRemoteDTO] = try await np.request(endpoint: "restaurants")
            response.forEach { dto in
                print(dto)
            }
        } catch {
            print(error)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
