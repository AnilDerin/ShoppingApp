//
//  FakeStoreAPI.swift
//  ShoppingApp
//
//  Created by Bartu Gençcan on 30.10.2022.
//

import Foundation
import Moya

// Moya plugin & provider
let provider = MoyaProvider<FakeStoreAPI>()

enum FakeStoreAPI {
    case allProducts
}

extension FakeStoreAPI: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://fakestoreapi.com") else {
            fatalError("Base URL not found or in incorrect format.")
        }
        
        return url
    }
    
    var path: String {
        switch self {
        case .allProducts: return "/products"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        switch self {
        case .allProducts:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}


