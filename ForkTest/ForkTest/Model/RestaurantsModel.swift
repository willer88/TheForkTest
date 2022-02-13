//
//  RestaurantModel.swift
//  ForkTest
//
//  Created by Wilmar on 10/02/22.
//

import Foundation

struct RestaurantsModel {
    var worker: RestaurantWorkerProtocol?
    
    init(worker: RestaurantWorkerProtocol) {
        self.worker = worker
    }
    
    func fetchRestaurants(completion: @escaping (Result<RestaurantsResponse, RestaurantsServiceError>) -> Void) {
        worker?.fetchRestaurants(completion: { response in
            completion(response)
        })
    }
}
