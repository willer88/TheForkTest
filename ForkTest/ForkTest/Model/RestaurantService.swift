//
//  RestaurantService.swift
//  ForkTest
//
//  Created by Wilmar on 10/02/22.
//

import Combine
import Foundation

enum RestaurantsServiceError: LocalizedError {
    case backend(error: String)
    case wrongData
}

protocol RestaurantWorkerProtocol {
    func fetchRestaurants(completion: @escaping (Result<RestaurantsResponse, RestaurantsServiceError>) -> Void)
}

struct RestaurantWorker: RestaurantWorkerProtocol {
    func fetchRestaurants(completion: @escaping (Result<RestaurantsResponse, RestaurantsServiceError>) -> Void) {
        
        var request = URLRequest(url: .restaurants())
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        
        let session = URLSession.shared
        
        session.dataTask(with: .restaurants()) { (data, response, error) in
            if let error = error {
                completion(.failure(.backend(error: error.localizedDescription)))
                
            } else {
                guard let data = data else {
                    completion(.failure(.wrongData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let posts = try decoder.decode(RestaurantsResponse.self, from: data)
                    completion(.success(posts))
                } catch {
                    completion(.failure(.backend(error: error.localizedDescription)))
                }
            }
        }.resume()
    }
}
