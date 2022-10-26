//
//  User.swift
//  ShoppingApp
//
//  Created by Bartu Gençcan on 26.10.2022.
//

import Foundation

struct User: Encodable {
    let username: String?
    let email: String?
    let pp: String?
    let basket: [String]?
}

extension User {
    init(from dict: [String: Any]) {
        username = dict["username"] as? String
        email = dict["email"] as? String
        pp = dict["pp"] as? String
        basket = dict["basket"] as? [String]
    }
}
