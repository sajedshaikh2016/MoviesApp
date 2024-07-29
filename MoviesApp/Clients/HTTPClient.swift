//
//  HTTPClient.swift
//  MoviesApp
//
//  Created by Sajed Shaikh on 29/07/24.
//

import Foundation
import Combine

enum NetworkError: Error {
    case badUrl
}

class HTTPClient {
    func fetchMovies(search: String) -> AnyPublisher<[Movie], Error> {
        guard let encodedSearch = search.urlEncoded,
              let url = URL(string: "https://www.omdbapi.com/?s=\(encodedSearch)&page=2&apiKey=47f3ff77")
        else {
            return Fail(error: NetworkError.badUrl).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .map(\.Search)
            .breakpoint(receiveOutput: { movies in
                movies.isEmpty
            })
            .receive(on: DispatchQueue.main)
            .catch { error -> AnyPublisher<[Movie], Error> in
                return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
