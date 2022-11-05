//
//  Product.swift
//  ShoppingApp
//
//  Created by Bartu Gençcan on 30.10.2022.
//

import Foundation

// MARK: - Product
struct Product: Codable {
    let id: Int?
    let title: String?
    let price: Double?
    let productDescription, category: String?
    let image: String?
    let rating: Rating?
    
    var dictionary: [String: Any] {
        return ["id": id ?? "",
                "title": title ?? "",
                "price": price ?? "",
                "productDescription": productDescription ?? "",
                "category": category ?? "",
                "image": image ?? "",
                "rating": rating?.rate ?? ""
        ]
    }
    var nsDictionary: NSDictionary {
        return dictionary as NSDictionary
    }

    enum CodingKeys: String, CodingKey {
        case id, title, price
        case productDescription = "description"
        case category, image, rating
    }
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double?
    let count: Int?
}

extension Product {
    init(from dict: [String: Any]) {
        id = dict["id"] as? Int
        title = dict["title"] as? String
        price = dict["price"] as? Double
        productDescription = dict["description"] as? String
        category = dict["category"] as? String
        image = dict["image"] as? String
        rating = dict["rating"] as? Rating
    }
}

