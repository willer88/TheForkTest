//
//  RestaurantsViewModel.swift
//  ForkTest
//
//  Created by Wilmar on 10/02/22.
//

import Foundation

struct RestaurantViewModel: Equatable {
    // MARK: Properties
    var name: String?
    var formattedRating: String?
    var ratingValue: Float?
    var address: String?
    var imageURL: String?
    var isFavorite: Bool?
    
    // MARK: Initialization
    init(restaurantModel: RestaurantResponse) {
        name = restaurantModel.name
        formattedRating = showRating(value: restaurantModel.aggregateRatings?.thefork?.ratingValue)
        ratingValue = restaurantModel.aggregateRatings?.thefork?.ratingValue
        address = showAddress(address: restaurantModel.address)
        imageURL = restaurantModel.mainPhoto?.source
        isFavorite = false
    }
    
    // MARK: Util
    private func showRating(value: Float?) -> String {
        guard let value = value else {
            return "Rating: N/A"
        }
        
        return "Rating: \(value) of 10.0"
    }
    
    private func showAddress(address: Address?) -> String {
        guard let street = address?.street else {
            return "Address: N/A"
        }

        return "Address: \(street)"
    }
}

class RestaurantsViewModel {
    // MARK: Properties
    var model: RestaurantsModel?
    var restaurants: [RestaurantViewModel]?
    
    // MARK: Initialization
    init(restaurantsModel: RestaurantsModel) {
        model = restaurantsModel
    }
    
    func fetchRestaurants(completion: @escaping (Result<Bool, RestaurantsServiceError>) -> Void) {
        model?.worker?.fetchRestaurants(completion: { result in
            switch result {
            case .success(let response):
                let restaurants = response.data?.map({ response in
                    return RestaurantViewModel(restaurantModel: response)
                })
                self.restaurants = restaurants
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func executeSorting(sortType: SortTypes) {
        if sortType == .name {
            restaurants?.sort(by: { $0.name ?? "" < $1.name ?? "" })
        } else if sortType == .rating {
            restaurants?.sort(by: { $0.ratingValue ?? 0.0 > $1.ratingValue ?? 0.0 })
        }
    }
}
