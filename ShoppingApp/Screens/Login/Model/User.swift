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
    
    var dictionary: [String: Any] {
        return ["username": username ?? "",
                "email": email ?? "",
                "pp": pp ?? "",
                "basket": basket ?? []
        ]
    }
    var nsDictionary: NSDictionary {
        return dictionary as NSDictionary
    }
}
