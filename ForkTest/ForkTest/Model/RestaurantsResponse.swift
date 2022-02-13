//
//  RestaurantsResponse.swift
//  ForkTest
//
//  Created by Wilmar on 10/02/22.
//

import Foundation

struct Address: Codable {
    var street: String?
    var postalCode: String?
    var locality: String?
    var country: String?
}

struct Rating: Codable {
    var ratingValue: Float?
    var reviewCount: Int?
}

struct AggregateRatings: Codable {
    var thefork: Rating?
    var tripadvisor: Rating?
}

struct MainPhoto: Codable {
    var source: String?
}

struct BestOffer: Codable {
    var name: String?
    var label: String?
}

struct RestaurantResponse: Codable {
    var name: String?
    var uuid: String?
    var servesCuisine: String?
    var priceRange: Int?
    var currenciesAccepted: String?
    var address: Address?
    var aggregateRatings: AggregateRatings?
    var mainPhoto: MainPhoto?
    var bestOffer: BestOffer?
}

struct RestaurantsResponse: Codable {
    var data: [RestaurantResponse]?
}
