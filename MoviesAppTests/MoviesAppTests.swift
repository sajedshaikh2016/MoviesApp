//
//  MoviesAppTests.swift
//  MoviesAppTests
//
//  Created by Sajed Shaikh on 29/07/24.
//

import XCTest
import Combine

final class MoviesAppTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable> = []
    
    func testFetchMovies() throws {
        let httpClient = HTTPClient()
        let expectations = XCTestExpectation(description: "Recieved movies")
        
        httpClient.fetchMovies(search: "Batman")
            .sink { complitions in
                switch complitions {
                case .finished:
                    return
                case .failure(let error):
                    XCTFail("Request failed with an error \(error)")
                }
            } receiveValue: { movies in
                XCTAssertTrue(movies.count > 0)
                expectations.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectations], timeout: 5.0)

    }
    
}
