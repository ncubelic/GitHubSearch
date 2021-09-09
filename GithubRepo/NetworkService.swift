//
//  NetworkService.swift
//  GithubRepo
//
//  Created by Nikola Čubelić on 09.09.2021..
//

import Combine
import Foundation

class NetworkService {
    
    private let session: URLSession
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func search(query: String) -> AnyPublisher<SearchModel, Error> {
        var urlComponents = URLComponents(string: Endpoint.searchEndpoint)
        urlComponents?.queryItems = [URLQueryItem(name: "q", value: query)]
        guard let endpoint = urlComponents?.url else { fatalError() }
        
        var request = URLRequest(url: endpoint)
        request.httpMethod = "GET"
        
        return session.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: SearchModel.self, decoder: decoder)
            .catch { _ in Empty<SearchModel, Error>() }
            .eraseToAnyPublisher()

    }
}

enum Endpoint {
    static let searchEndpoint = "https://api.github.com/search/repositories"
}
